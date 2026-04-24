#!/bin/bash
set -e

# Экспорт переменных окружения для локальной разработки
export DATABASE_URL="postgresql+asyncpg://user:pass@localhost:5432/ether"
export REDIS_URL="redis://localhost:6379"
export SECRET_KEY="devsecretkey"
export ALLOWED_ORIGINS='["http://localhost:8080","http://localhost:5000"]'

echo "Starting Ether Guardians backend..."
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload