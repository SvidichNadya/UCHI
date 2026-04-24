import json
from fastapi import APIRouter, WebSocket, WebSocketDisconnect, Depends
from app.services.connection_manager import ConnectionManager
from app.core.security import get_current_user_ws

router = APIRouter()
manager = ConnectionManager()

@router.websocket("/play/{room_id}")
async def websocket_endpoint(
    websocket: WebSocket,
    room_id: str,
    token: str = None
):
    user = await get_current_user_ws(token)  # JWT валидация
    await manager.connect(websocket, room_id, user.id)
    try:
        while True:
            data = await websocket.receive_json()
            # Валидация схемы пакета (координаты, действие)
            await manager.broadcast(data, room_id, exclude=websocket)
    except WebSocketDisconnect:
        await manager.disconnect(websocket, room_id)
    except Exception as e:
        print(f"WS error: {e}")
        await manager.disconnect(websocket, room_id)