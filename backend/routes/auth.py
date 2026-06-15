import uuid
import bcrypt
from pydantic_scheme.user_login import UserLogin
from models.user import User
from pydantic_scheme.user_create import CreateUser
from fastapi import APIRouter, Depends, HTTPException, Header
from database import get_db
from sqlalchemy.orm import Session
import jwt
from middleware.auth_middleware import auth_middleware

router = APIRouter()

@router.post('/signup', status_code=201)
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

@router.post('/login')
def login_user(user: UserLogin, db: Session = Depends(get_db)):
    #check if a user exists with the email
    user_db = db.query(User).filter(User.email == user.email).first()

    if not user_db:
        raise HTTPException(status_code = 400, detail = "User does not exist")
    
    #password matching or not
    pass_not_match=bcrypt.checkpw(user.password.encode(), user_db.password)
    
    if not pass_not_match:
        raise HTTPException(status_code=400, detail="Incorrect password")
    
    token = jwt.encode({'id': user_db.id}, 'password_key')
    
    return {'token' : token, 'user': user_db}

@router.get('/')
def current_user_data(db: Session=Depends(get_db), user_dict = Depends(auth_middleware)):
    user = db.query(User).filter(User.id == user_dict['uid']).first()

    if not user:
        raise HTTPException(404,'User not found')
    
    return user