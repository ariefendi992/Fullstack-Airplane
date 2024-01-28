import email
from flask import Flask, request
from app.core.config import Settings
from app.models.user_model import UserModel
from app.routes import register_routes
from app.extensions import jwt


def create_app():
    app = Flask(__name__)
    app.config.from_object(Settings)
    app.json_provider_class.sort_keys = False

    register_extensions(app)
    register_routes(app)

    @jwt.user_identity_loader
    def user_identity_lookup(user):
        print(f"user loader : {user}")
        return user

    @jwt.user_lookup_loader
    def user_lookup_callback(_jwt_header, jwt_data):
        identity = jwt_data["sub"]["email"]
        print(f"Identity user2 : {identity}")
        return UserModel.query.filter_by(email=identity).one_or_none()

    @app.get("/")
    def hello():
        return request.environ.get("SERVER_PROTOCOL")

    return app


def register_extensions(app: Flask):
    from app.extensions import db, migrate, jwt

    db.init_app(app)
    migrate.init_app(app, db)
    jwt.init_app(app)
