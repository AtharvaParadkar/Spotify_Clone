from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class CreateUser(BaseModel):
    username: str
    email: str
    password: str

@app.post('/signup')
def signup_user(user: CreateUser):
    #extract data coming from request
    print(user)
    #check if user already exists
    #add user to db
    
    return "😀"
