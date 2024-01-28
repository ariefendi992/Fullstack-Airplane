from functools import lru_cache
import os


class Settings:
    SQLALCHEMY_DATABASE_URI = "sqlite:///database.db"
    SQLALCHEMY_TRACK_MODIFICATIONS = True
    SQLALCHEMY_RECORD_QUERIES = True
    SQLALCHEMY_ECHO = False

    JWT_SECRET_KEY = os.getenv("SECRET_KEY")

    JWT_TOKEN_LOCATION = ["headers", "cookies", "json", "query_string"]
    JWT_COOKIE_SECURE = False

    ALLOWED_EXTENSIONS = {"txt", "pdf", "png", "jpg", "jpeg", "gif"}
    UPLOAD_FOLDER = os.getcwd() + "/app/static/images/"

    DEBUG = True
    # HOST = os.getenv("FLASK_RUN_HOST")

    @classmethod
    def allowed_ext(cls, filename: str):
        return (
            "." in filename and filename.split(".")[1].lower() in cls.ALLOWED_EXTENSIONS
        )


# @lru_cache
# def config():
#     return Settings()
