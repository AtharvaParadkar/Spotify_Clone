from models.base import Base
from pydantic_scheme.user_create import CreateUser
from database import engine
from fastapi import FastAPI
from routes import auth

app = FastAPI()

app.include_router(auth.router, prefix = '/auth')

Base.metadata.create_all(bind=engine)