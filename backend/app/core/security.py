from datetime import datetime, timedelta
from jose import JWTError, jwt
from passlib.context import CryptContext
from fastapi import Depends, HTTPException, status, WebSocket
from fastapi.security import OAuth2PasswordBearer
from app.core.config import settings

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/auth/login")

def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES))
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, settings.SECRET_KEY, algorithm="HS256")

async def get_current_parent(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
        parent_id = payload.get("sub")
        if parent_id is None:
            raise HTTPException(status_code=401, detail="Invalid token")
        # Здесь можно вернуть объект Parent из БД
        return type('Parent', (), {'id': int(parent_id)})
    except JWTError:
        raise HTTPException(status_code=401, detail="Could not validate credentials")

async def get_current_user_id(token: str = Depends(oauth2_scheme)):
    """Возвращает ID пользователя (ребёнка) из токена."""
    parent = await get_current_parent(token)
    # В реальном приложении здесь была бы проверка принадлежности ребёнка родителю
    # и извлечение child_id. Пока возвращаем фиксированный id для демо.
    return 1  # Заглушка на время MVP

async def get_current_user_ws(token: str):
    """Валидация для WebSocket (упрощённая)."""
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=["HS256"])
        return type('User', (), {'id': int(payload.get("sub"))})
    except JWTError:
        raise HTTPException(status_code=401, detail="Invalid WS token")