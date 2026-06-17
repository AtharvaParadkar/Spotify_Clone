from uuid import uuid4

import cloudinary
import cloudinary.uploader
import os
from dotenv import load_dotenv
from fastapi import APIRouter, UploadFile, File, Form, Depends 
from sqlalchemy.orm import Session
from middleware.auth_middleware import auth_middleware
from database import get_db

load_dotenv()

router = APIRouter()

# Configuration       
cloudinary.config( 
    cloud_name = os.getenv("CLOUDINARY_CLOUD_NAME"), 
    api_key = os.getenv("CLOUDINARY_API_KEY"), 
    api_secret = os.getenv("CLOUDINARY_API_SECRET"),
    secure=True
)

@router.post('/upload')
def upload_song(
    song: UploadFile = File(...), 
    thumbnail: UploadFile = File(...), 
    artist: str = Form(...),
    song_name: str = Form(...),
    hex_code: str = Form(...),
    db: Session = Depends(get_db),
    auth_dict = Depends(auth_middleware)
    ):
    song_id = str(uuid4())
    song_res = cloudinary.uploader.upload(song.file, resource_type = 'auto', folder = f'songs/{song_id}')
    print(song_res)
    thumbnail_res = cloudinary.uploader.upload(thumbnail.file, resource_type = 'image', folder = f'songs/{song_id}')
    print(thumbnail_res)
    return 'ok'