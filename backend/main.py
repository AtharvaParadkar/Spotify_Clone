from models.base import Base
from pydantic_scheme.user_create import CreateUser
from database import engine
from fastapi import FastAPI  # type: ignore[reportMissingImports]
from routes import auth, song

app = FastAPI()

app.include_router(auth.router, prefix = '/auth')
app.include_router(song.router, prefix = '/song')

Base.metadata.create_all(bind=engine)