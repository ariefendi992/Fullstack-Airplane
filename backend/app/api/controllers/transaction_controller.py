from flask import Blueprint, jsonify, request
from flask_jwt_extended import get_jwt_identity, jwt_required
from app.models.destination_model import DestinationModel
from app.extensions import db
from app.models.transaction_model import TransactionModel
from app.models.user_model import UserModel

transasction = Blueprint("transaction", __name__, url_prefix="/api/v1/transaction")


@transasction.get("/")
def trasactions():
    data = []
    query = db.session.query(TransactionModel).join(DestinationModel).all()
    for item in query:
        data.append(
            {
                "id": item.id,
                "amountOfTraveler": item.amount_of_traveler,
                "grandTotal": item.grand_total,
                "price": item.price,
                "refundable": item.refundable,
                "selectedSeats": item.selected_seats,
                "vat": item.vat,
                "destination_id": item.destination_id,
                "destination": {
                    "id": item.destination.id,
                    "imgUrl": item.destination.imgUrl,
                    "name": item.destination.name,
                    "city": item.destination.city,
                    "price": item.destination.price,
                    "rating": item.destination.rating,
                    "isNew": item.destination.is_new,
                    "isPopular": item.destination.is_popular,
                },
            }
        )

    resp = jsonify(data=data)
    resp.status_code = 200
    return resp


@transasction.route("/create", methods=["GET", "POST"])
@jwt_required()
def create():
    identity = get_jwt_identity()["email"]
    user: UserModel = UserModel.query.filter_by(email=identity).first()

    if not user:
        resp = jsonify(msg="Authentaced failed!")
        resp.status_code = 401
        return resp

    # id = request.args.get("id")
    # destination: DestinationModel = DestinationModel.query.filter_by(id=id).first()

    # print(f"Destinati ID {destination.id}")
    # if not destination:
    #     resp = jsonify(msg="Destination id is not found!")
    #     resp.status_code = 404
    #     return resp

    # else:
    amount = request.json.get("amountOfTraveler")
    grandTotal = request.json.get("grandTotal")
    insurance = request.json.get("insurance")
    price = request.json.get("price")
    refundable = request.json.get("refundable")
    selectedSeats = request.json.get("selectedSeats")
    vat = request.json.get("vat")
    destination_id = int(request.json.get("destination_id"))

    transactionQuery = TransactionModel(
        amountOfTraveler=amount,
        grandTotal=grandTotal,
        insurance=insurance,
        price=price,
        refundable=refundable,
        selectedSeats=selectedSeats,
        vat=vat,
        destination_id=destination_id,
    )

    transactionQuery.save()
    user.balance = user.balance - price
    user.save()

    resp = jsonify(msg="add transaction success")
    resp.status_code = 200
    return resp


@transasction.get("/single")
def single():
    id = request.args.get("id")
    item: TransactionModel = TransactionModel.query.filter_by(id=id).first()

    if not item:
        resp = jsonify(msg="Transaction item not found")
        resp.status_code = 404
        return resp

    else:
        data = {
            "id": item.id,
            "amountOfTraveler": item.amount_of_traveler,
            "grandTotal": item.grand_total,
            "insurance": item.insurance,
            "price": item.price,
            "refundable": item.refundable,
            "selectedSeats": item.selected_seats,
            "vat": item.vat,
            "destination_id": item.destination_id,
            "destination": item.destination,
        }

        resp = jsonify(data)
        resp.status_code = 200
        return resp
