import uuid
import bcrypt
from models.user import User
from pydantic_scheme.user_create import CreateUser
from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from sqlalchemy.orm import Session

router = APIRouter()

@router.post('/signup')
def signup_user(user: CreateUser, db : Session = Depends(get_db)):
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