from flask import Flask
from app.api.controllers.user_controller import user
from app.api.controllers.auth_controller import auth
from app.api.controllers.destionation_controller import destination
from app.api.controllers.transaction_controller import transasction


def register_routes(app: Flask):
    app.register_blueprint(user)
    app.register_blueprint(auth)
    app.register_blueprint(destination)
    app.register_blueprint(transasction)
