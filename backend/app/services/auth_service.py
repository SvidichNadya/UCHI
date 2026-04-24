from passlib.context import CryptContext
from app.models.user import Parent

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def get_password_hash(password):
    return pwd_context.hash(password)

# В реальном проекте – запросы к БД
async def authenticate_parent(email: str, password: str, db):
    # Заглушка
    return None