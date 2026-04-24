from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    DATABASE_URL: str = "postgresql+asyncpg://user:pass@localhost:5432/ether"
    REDIS_URL: str = "redis://localhost:6379"
    SECRET_KEY: str = "supersecretkey"
    ALLOWED_ORIGINS: list = ["http://localhost:8080", "http://localhost:3000"]
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 30

    class Config:
        env_file = ".env"

settings = Settings()