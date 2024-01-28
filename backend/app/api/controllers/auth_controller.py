from datetime import timedelta
from tkinter import E
from flask import Blueprint, jsonify, request
from flask_jwt_extended import (
    create_access_token,
    create_refresh_token,
    get_current_user,
    get_jti,
    get_jwt_header,
    get_jwt_identity,
    get_jwt_request_location,
    set_access_cookies,
    jwt_required,
    unset_access_cookies,
    unset_jwt_cookies,
)
from app.core.security import check_password

from app.models.user_model import UserModel

auth = Blueprint("auth", __name__, url_prefix="/api/v1/auth")


@auth.post("/login")
def sign_in():
    email = request.json.get("email")
    password = request.json.get("password")
    user: UserModel = UserModel.query.filter_by(email=email).first()

    if not user:
        resp = jsonify(msg="User email is wrong!")
        resp.status_code = 401
        return resp
    else:
        if not check_password(passwordHash=user.password, password=password):
            resp = jsonify(msg="User password is wrong!")
            resp.status_code = 401
            return resp

        else:
            email = user.email
            expr_delta = timedelta(seconds=20)
            access_token = create_access_token(
                identity={"email": email},
                # expires_delta=expr_delta,
                # fresh=timedelta(seconds=15),
            )

            refresh_token = create_refresh_token(identity={"email": email})

            resp = jsonify(access_token=access_token, refersh_token=refresh_token)
            set_access_cookies(resp, access_token)
            return resp


@auth.get("/refresh")
@jwt_required(fresh=True)
def d():
    identity = get_jwt_identity()
    access_token = create_access_token(identity=identity, fresh=False)

    resp = jsonify(access_token=access_token)
    resp.status_code = 200
    return resp


@auth.get("/anonymous")
@jwt_required(optional=True, fresh=True)
def optional_protected():
    identity = get_jwt_identity()
    if identity:
        return jsonify(login_as=identity)
    else:
        return jsonify(msg="is anonymous user")


@auth.post("/logout")
def logout():
    resp = jsonify(msg="logout successful")
    unset_jwt_cookies(resp)
    unset_access_cookies(resp)
    resp.status_code = 200
    return resp
