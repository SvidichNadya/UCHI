from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.database import get_session
from app.schemas.analytics import TelemetryPayload
from app.models.session import GameSession
from app.core.security import get_current_user_id

router = APIRouter()

@router.post("/log")
async def log_telemetry(
    payload: TelemetryPayload,
    user_id: int = Depends(get_current_user_id),
    db: AsyncSession = Depends(get_session)
):
    # Обновляем запись сессии
    # (реальная реализация через сервис)
    return {"status": "ok", "session_id": payload.session_id}