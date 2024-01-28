from uuid import uuid4
from app.extensions import db
from sqlalchemy import Column, Integer, String, Text, BIGINT


class UserModel(db.Model):
    __tablename__ = "user"
    id = Column(Integer, primary_key=True, autoincrement=True)
    uid = Column(String(32), nullable=False, unique=True)
    email = Column(String(64), nullable=False)
    password = Column(Text, nullable=False)
    name = Column(String(64), nullable=False)
    hobby = Column(String(32), nullable=True)
    balance = Column(BIGINT, nullable=True)

    def __init__(
        self,
        *,
        email: str,
        password: str,
        name: str,
        hobby: str | None = None,
        balance: int | None = 0,
    ) -> str:
        self.uid = str(uuid4())
        self.email = email
        self.password = password
        self.name = name
        self.hobby = hobby
        self.balance = 280000000 if not balance or balance == 0 else balance

    def __repr__(self) -> str:
        return f"[{self.name}, {self.email} ]"

    def save(self):
        db.session.add(self)
        db.session.commit()
        db.session.refresh(self)
