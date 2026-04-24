from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime

class TelemetryPayload(BaseModel):
    session_id: int
    child_id: int
    wcpm: Optional[float] = 0.0
    active_minutes: Optional[float] = 0.0
    craft_completed: bool = False
    alternative_path_used: bool = False
    cooperative_action: bool = False

class SessionSummary(BaseModel):
    session_id: int
    duration_minutes: float
    words_read: int
    wcpm: float
    movement_minutes: float
    craft_count: int
    fluid_routing_count: int
    cooperation_rating: float
    finished_at: datetime