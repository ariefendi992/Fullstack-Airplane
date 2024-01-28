from email_validator import validate_email, EmailNotValidError
from werkzeug.security import check_password_hash, generate_password_hash


def check_validate_email(*, email: str) -> bool:
    try:
        _validate = validate_email(email, check_deliverability=False)
        return True
    except EmailNotValidError as e:
        if e:
            return False


def create_password_hash(*, password: str) -> bool:
    return generate_password_hash(password)


def check_password(*, passwordHash: str, password: str) -> bool:
    return check_password_hash(pwhash=passwordHash, password=password)
