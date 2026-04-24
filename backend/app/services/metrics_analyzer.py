from sqlalchemy.ext.asyncio import AsyncSession
from app.models.session import GameSession

async def get_child_sessions(child_id: int, db: AsyncSession):
    # Пример запроса (реальная логика SELECT + агрегация)
    return [
        {
            "session_id": 1,
            "duration_minutes": 28.5,
            "words_read": 45,
            "wcpm": 68.2,
            "movement_minutes": 12.0,
            "craft_count": 1,
            "fluid_routing_count": 1,
            "cooperation_rating": 0.9,
            "finished_at": "2026-04-24T18:30:00"
        }
    ]