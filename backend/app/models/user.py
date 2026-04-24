from sqlalchemy import Column, Integer, String, Boolean, DateTime, func
from app.db.database import Base

class Parent(Base):
    __tablename__ = "parents"
    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)

class ChildProfile(Base):
    __tablename__ = "child_profiles"
    id = Column(Integer, primary_key=True, index=True)
    parent_id = Column(Integer, nullable=False)
    name = Column(String, nullable=False)
    age = Column(Integer, nullable=False)
    accessibility_flags = Column(String, default="")  # comma-separated flags: motor, speech, sensory
    created_at = Column(DateTime(timezone=True), server_default=func.now())