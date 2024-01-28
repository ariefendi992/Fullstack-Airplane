from flask import Blueprint, request, jsonify, g
from app.core.security import check_validate_email, create_password_hash
from app.extensions import db
from app.models.user_model import UserModel
from flask_jwt_extended import get_jwt_identity, jwt_required, current_user

user = Blueprint("user", __name__, url_prefix="/api/v1/users")


@user.get("/")
def users():
    data = []
    users = db.session.query(UserModel).all()

    for i in users:
        data.append(
            {
                "id": i.id,
                "email": i.email,
                "name": i.name,
                "hobby": i.hobby,
                "balance": i.balance,
            }
        )

    resp = jsonify(data=data)
    resp.status_code = 200
    return resp


@user.post("/create")
def create():
    email = request.json.get("email")
    password = request.json.get("password")
    name = request.json.get("name")
    hobby = request.json.get("hobby")
    balance = request.json.get("balance")

    _emailIsValid = check_validate_email(email=email)

    if not email or not password or not name:
        resp = jsonify(msg="email, password, name is required!")
        resp.status_code = 400
        return resp

    if not _emailIsValid:
        resp = jsonify(msg="Email address is not valid")
        resp.status_code = 400
        return resp

    if len(password) < 6:
        resp = jsonify(msg="Password length is must be have minimal 6 character's")
        resp.status_code = 400
        return resp

    password_hash = create_password_hash(password=password)

    if UserModel.query.filter_by(email=email).first():
        resp = jsonify(msg="User with email is already exists!")
        resp.status_code = 409
        return resp
    else:
        user = UserModel(
            email=email, password=password_hash, name=name, hobby=hobby, balance=balance
        )

        db.session.add(user)
        db.session.commit()
        db.session.refresh(user)

        resp = jsonify(msg=f"User with email : {email} and is created")
        resp.status_code = 201
        return resp


@user.get("/user")
@jwt_required()
def single():
    identity = get_jwt_identity()["email"]
    user: UserModel = UserModel.query.filter_by(email=identity).first()

    if not user:
        resp = jsonify(msg="User not found!")
        resp.status_code = 404
        return resp
    else:
        data = {
            "id": user.id,
            "email": user.email,
            "name": user.name,
            "hobby": user.hobby,
            "balance": user.balance,
        }

        resp = jsonify(data)
        resp.status_code = 200
        return resp


@user.put("/user")
def update():
    id = request.args.get("id")
    user: UserModel = UserModel.query.filter_by(id=id).first()
    if not user:
        resp = jsonify(msg="User not found!")
        resp.status_code = 404
        return resp
    else:
        email = request.json.get("email")
        name = request.json.get("name")
        hobby = request.json.get("hobby")
        balance = request.json.get("balance")

        _emailIsValid = check_validate_email(email=email)

        if not _emailIsValid:
            resp = jsonify(msg="Email not valid")
            resp.status_code = 400
            return resp

        user.email = email
        user.name = name
        user.hobby = hobby
        user.balance = balance

        db.session.commit()
        db.session.refresh(user)

        resp = jsonify(msg="User is updated!")
        resp.status_code = 200
        return resp


@user.put("/user-password")
def update_password():
    uid = request.args.get("id")
    user: UserModel = UserModel.query.filter_by(uid=uid).first()
    if not user:
        resp = jsonify(msg="User not found!")
        resp.status_code = 404
        return resp
    else:
        user.password = create_password_hash(password=request.json.get("password"))

        db.session.commit()
        db.session.refresh(user)

        resp = jsonify(msg="Password is updated!")
        resp.status_code = 200
        return resp


@user.delete("/user")
def delete():
    id = request.args.get("id")
    user: UserModel = UserModel.query.filter_by(id=id).first()
    if not user:
        resp = jsonify(msg="User not found!")
        resp.status_code = 404
        return resp
    else:
        db.session.delete(user)
        db.session.commit()
        # db.session.refresh(user)

        resp = jsonify(msg="User is deleted!")
        resp.status_code = 204
        return resp


@user.delete("delete-all")
def delete_all():
    user = UserModel.query.all()

    for i in user:
        sigle_user = UserModel.query.filter_by(id=i.id).first()
        db.session.delete(sigle_user)
        db.session.commit()

    resp = jsonify(msg="All users is deleted.")
    resp.status_code = 204
    return resp
