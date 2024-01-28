from fileinput import filename
import os
from flask import Blueprint, jsonify, request, url_for, current_app
from flask_jwt_extended import jwt_required
from app.core.config import Settings
from app.models.destination_model import DestinationModel

destination = Blueprint("destination", __name__, url_prefix="/api/v1/destination")


@destination.get("/")
# @jwt_required()
def destinations():
    # isPopular = request.args.get(key="popular", type=bool)
    # isNew = request.args.get(key="new", type=bool)

    # if isPopular:
    #     query = DestinationModel.query.filter_by(is_popular=isPopular).all()

    # elif isNew
    data = []
    destination_query: list[DestinationModel] = DestinationModel.query.order_by(
        DestinationModel.name.asc()
    ).all()

    for item in destination_query:
        # imgUrl = item.imgUrl.split("/")[3]
        data.append(
            {
                "id": item.id,
                # "imgUrl": url_for("static", filename=f"images/{imgUrl}"),
                "imgUrl": item.imgUrl,
                "name": item.name,
                "city": item.city,
                "rating": item.rating,
                "price": item.price,
                "isNew": item.is_new,
                "isPopular": item.is_popular,
            }
        )

    resp = jsonify(data=data)
    resp.status_code = 200
    return resp


@destination.post("/upload")
def upload():
    f = request.files["image"]
    name: str = request.form["name"]
    city: str = request.form["city"]
    price: int = request.form["price"]
    rating: float = request.form["rating"]
    is_new: bool = True if request.form.get("is_new") == "true" else False
    is_popular = True if request.form.get("is_popular") == "true" else False

    if f.filename == "":
        resp = jsonify(msg="No select image")
        resp.status_code = 404
        return resp
    if f and Settings().allowed_ext(f.filename):
        filename = f.filename
        f.save(os.path.join(current_app.config["UPLOAD_FOLDER"], filename))

        img_url = url_for("static", filename=f"images/{filename}")

        query = DestinationModel(
            imgUrl=img_url,
            name=name,
            city=city,
            price=price,
            rating=rating,
            isNew=is_new,
            isPopular=is_popular,
        )

        query.save()

        resp = jsonify(msg="upload success")
        resp.status_code = 200
        return resp


@destination.get("/single")
def single():
    id = request.args.get("id")
    item: DestinationModel = DestinationModel.query.filter_by(id=id).first()

    if not item:
        resp = jsonify(msg="Data not found!")
        resp.status_code = 404
        return resp

    else:
        data = {
            "id": item.id,
            "name": item.name,
            "city": item.city,
            "imgUrl": item.imgUrl,
            "price": item.price,
            "rating": item.rating,
            "isNew": item.is_new,
            "isPopular": item.is_popular,
        }

        resp = jsonify(data)
        resp.status_code = 200
        return resp


@destination.put("/single")
def update():
    id = request.args.get("id")
    item: DestinationModel = DestinationModel.query.filter_by(id=id).first()

    if not item:
        resp = jsonify(msg="Data not found!")
        resp.status_code = 404
        return resp

    else:
        # data = {
        #     "id": item.id,
        #     "name": item.name,
        #     "city": item.city,
        #     "imgUrl": item.imgUrl,
        #     "price": item.price,
        #     "rating": item.rating,
        #     "isNew": item.is_new,
        #     "isPopular": item.is_popular,
        # }
        is_new = request.json.get("isNew")

        item.is_new = is_new
        item.save()

        resp = jsonify(msg="update susccess!")
        resp.status_code = 200
        return resp
