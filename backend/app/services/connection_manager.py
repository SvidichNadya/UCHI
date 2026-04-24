import asyncio
import json
from typing import Dict, Set, Optional
from fastapi import WebSocket
import redis.asyncio as redis
from app.core.config import settings

class ConnectionManager:
    def __init__(self):
        self.rooms: Dict[str, Dict[int, WebSocket]] = {}  # room_id -> user_id -> ws
        self.lock = asyncio.Lock()
        self.redis = redis.from_url(settings.REDIS_URL, decode_responses=True)

    async def connect(self, websocket: WebSocket, room_id: str, user_id: int):
        await websocket.accept()
        async with self.lock:
            if room_id not in self.rooms:
                self.rooms[room_id] = {}
            self.rooms[room_id][user_id] = websocket
        # Подписка на Redis канал комнаты (для масштабирования)
        self.pubsub = self.redis.pubsub()
        await self.pubsub.subscribe(f"room:{room_id}")
        # В фоне слушаем Redis и отправляем клиенту
        asyncio.create_task(self._listen_redis(room_id))

    async def disconnect(self, websocket: WebSocket, room_id: str):
        async with self.lock:
            if room_id in self.rooms:
                user_to_remove = None
                for uid, ws in self.rooms[room_id].items():
                    if ws == websocket:
                        user_to_remove = uid
                        break
                if user_to_remove:
                    del self.rooms[room_id][user_to_remove]
                if not self.rooms[room_id]:
                    del self.rooms[room_id]
        await self.pubsub.unsubscribe(f"room:{room_id}")

    async def broadcast(self, message: dict, room_id: str, exclude: WebSocket = None):
        # Публикуем в Redis для других инстансов
        await self.redis.publish(f"room:{room_id}", json.dumps(message))
        # Также отправляем локальным клиентам
        async with self.lock:
            if room_id in self.rooms:
                tasks = []
                for ws in self.rooms[room_id].values():
                    if ws != exclude:
                        tasks.append(ws.send_json(message))
                await asyncio.gather(*tasks, return_exceptions=True)

    async def _listen_redis(self, room_id: str):
        async for raw_message in self.pubsub.listen():
            if raw_message['type'] == 'message':
                data = json.loads(raw_message['data'])
                async with self.lock:
                    if room_id in self.rooms:
                        tasks = []
                        for ws in self.rooms[room_id].values():
                            tasks.append(ws.send_json(data))
                        await asyncio.gather(*tasks, return_exceptions=True)