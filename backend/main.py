from fastapi import FastAPI
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, TEXT, VARCHAR, LargeBinary
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

app = FastAPI()

DATABASE_URL = "postgresql://postgres:qwerty@localhost:5432/spotify_clone"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit = False, autoflush = False, bind = engine)

db = SessionLocal()

class CreateUser(BaseModel):
    username: str
    email: str
    password: str

Base = declarative_base()

class User(Base):
    __tablename__ = "users"

    id = Column(TEXT, primary_key=True)
    name = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)

@app.post('/signup')
def signup_user(user: CreateUser):
    #extract data coming from request
    print(user)
    #check if user already exists
    #add user to db
    
    return "😀"

Base.metadata.create_all(bind=engine)