from typing import Any
from uuid import uuid4
from sqlalchemy import BIGINT, Column, Integer, String, Boolean, Float
from app.extensions import db


class DestinationModel(db.Model):
    __tablename__ = "destination"
    id = Column(Integer, primary_key=True, autoincrement=True)
    uid = Column(
        String(64),
    )
    imgUrl = Column(String(128))
    name = Column(String(64))
    city = Column(String(64))
    price = Column(BIGINT)
    rating = Column(Float)
    is_new = Column(Boolean)
    is_popular = Column(Boolean)

    def __init__(
        self,
        *,
        imgUrl: str,
        name: str,
        city: str,
        price: int,
        rating: float,
        isNew: bool,
        isPopular: bool
    ) -> Any:
        self.uid = str(uuid4())
        self.imgUrl = imgUrl
        self.name = name
        self.city = city
        self.price = price
        self.rating = rating
        self.is_new = isNew
        self.is_popular = isPopular

    def save(self):
        db.session.add(self)
        db.session.commit()
        db.session.refresh(self)
