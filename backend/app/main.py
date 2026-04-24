from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api import websockets, telemetry, parents
from app.core.config import settings
from app.db.database import engine, Base
import asyncio

app = FastAPI(title="Ether Guardians API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.ALLOWED_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(websockets.router, prefix="/ws", tags=["multiplayer"])
app.include_router(telemetry.router, prefix="/api/telemetry", tags=["telemetry"])
app.include_router(parents.router, prefix="/api/parents", tags=["parents"])

@app.on_event("startup")
async def startup():
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)

@app.get("/")
async def root():
    return {"message": "Ether Guardians Backend"}