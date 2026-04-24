from sqlalchemy import Column, Integer, String, Float, DateTime, func
from app.db.database import Base

class GameSession(Base):
    __tablename__ = "game_sessions"
    id = Column(Integer, primary_key=True, index=True)
    child_id = Column(Integer, nullable=False, index=True)
    start_time = Column(DateTime(timezone=True), server_default=func.now())
    end_time = Column(DateTime(timezone=True), nullable=True)
    wcpm = Column(Float, default=0.0)                 # Words correct per minute
    movement_minutes = Column(Float, default=0.0)     # minutes of moderate+ activity
    crafting_attempts = Column(Integer, default=0)
    fluid_routing_used = Column(Integer, default=0)   # how many times alternatives triggered
    cooperative_tasks = Column(Integer, default=0)
    status = Column(String, default="in_progress")    # in_progress, completed, abandoned