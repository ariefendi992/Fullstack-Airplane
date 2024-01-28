from uuid import uuid4
from sqlalchemy import BIGINT, Boolean, Column, Float, ForeignKey, Integer, String
from sqlalchemy.orm import relationship, Mapped
from app.extensions import db
from app.models.destination_model import DestinationModel


class TransactionModel(db.Model):
    __tablename__ = "transaction"
    id = Column(Integer, primary_key=True, autoincrement=True)
    uid = Column(String(64))
    amount_of_traveler = Column(Integer)
    grand_total = Column(BIGINT)
    insurance = Column(Boolean)
    price = Column(BIGINT)
    refundable = Column(Boolean)
    selected_seats = Column(String(64))
    vat = Column(Float)
    destination_id = Column(Integer, ForeignKey("destination.id"))
    destination: Mapped["DestinationModel"] = relationship(
        "DestinationModel", backref="transaction", lazy="joined"
    )

    def __init__(
        self,
        *,
        amountOfTraveler: int,
        grandTotal: int,
        insurance: bool,
        price: int,
        refundable: bool,
        selectedSeats: str,
        vat: float,
        destination_id: int,
    ) -> None:
        self.uid = str(uuid4())
        self.amount_of_traveler = amountOfTraveler
        self.grand_total = grandTotal
        self.insurance = insurance
        self.price = price
        self.refundable = refundable
        self.selected_seats = selectedSeats
        self.vat = vat
        self.destination_id = destination_id

    def __repr__(self) -> str:
        return f"{self.grand_total}"

    def save(self):
        db.session.add(self)
        db.session.commit()
        db.session.refresh(self)
