from pydantic import BaseModel, Field
from typing import List, Optional

class SkeletonPacket(BaseModel):
    user_id: int
    room_id: str
    landmarks: List[List[float]]  # 33 точки * [x, y, z]
    timestamp: float

class GameActionPacket(BaseModel):
    user_id: int
    room_id: str
    action: str                  # "squat_done", "spell_read", "craft_submitted"
    payload: Optional[dict] = {}