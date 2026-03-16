from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from sqlalchemy import create_engine, Column, TEXT, VARCHAR, LargeBinary
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
import uuid
import bcrypt

app = FastAPI()

DATABASE_URL = "postgresql://postgres:qwerty@localhost:5432/spotify_clone"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit = False, autoflush = False, bind = engine)

db = SessionLocal()

class CreateUser(BaseModel):
    name: str
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
    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(status_code = 400, detail = "User already exists with same email")

    #add user to db
    hashed_password = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    user_db = User(
        id = str(uuid.uuid4()),
        name = user.name,
        email = user.email,
        password = hashed_password
    )
    db.add(user_db)
    db.commit()
    db.refresh(user_db)
    
    return user_db

Base.metadata.create_all(bind=engine)