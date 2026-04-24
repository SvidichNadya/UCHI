from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.database import get_session
from app.core.security import get_current_parent

router = APIRouter()

@router.get("/children")
async def list_children(
    parent = Depends(get_current_parent),
    db: AsyncSession = Depends(get_session)
):
    # Заглушка на время MVP
    return [{"id": 1, "parent_id": parent.id, "name": "Анна", "age": 8}]

@router.get("/sessions/{child_id}")
async def child_sessions(
    child_id: int,
    parent = Depends(get_current_parent),
    db: AsyncSession = Depends(get_session)
):
    # Заглушка
    if child_id != 1:
        raise HTTPException(status_code=404, detail="Child not found")
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