# ⚙️ Spotify Clone — Backend

The backend server for the Spotify Clone, built with **Python**, **FastAPI**, and **PostgreSQL**. It exposes a secure RESTful API for user authentication, track upload, track retrieval, and favorites management. Media storage (audio tracks and cover art) is handled via **Cloudinary**.

<!-- uvicorn main:app --reload
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```
```ngrok
run this command in cmd to add token
ngrok config add-authtoken 3B6e7RO6iKDuhDW6fOqT8vCgJ58_2YLzabKamUkBj8gHZ3HRi
In 1 terminal run the server
In second terminal
ngrok http 8000 -->

---

## 🗂️ Project Structure

```text
backend/
├── main.py                  # Entry point for the FastAPI application
├── database.py              # SQLAlchemy engine config and DB session generator
├── requirements.txt         # Project dependencies
├── .env                     # Cloudinary authentication credentials
├── middleware/
│   └── auth_middleware.py   # JWT validation middleware extracting 'x-auth-token'
├── models/
│   ├── base.py              # Base declaration for SQLAlchemy tables
│   ├── user.py              # SQLAlchemy user model
│   ├── song.py              # SQLAlchemy song model
│   └── favorite.py          # SQLAlchemy favorite relations model
├── pydantic_scheme/
│   ├── user_create.py       # Pydantic schema for signup parameters
│   ├── user_login.py        # Pydantic schema for login parameters
│   └── favorite_song.py     # Pydantic schema for favoriting actions
└── routes/
    ├── auth.py              # Routes for auth: signup, login, get user profile
    └── song.py              # Routes for songs: upload, list, toggle favorite, list favorites
```

---

## 🚀 Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **FastAPI** | High-performance asynchronous REST API framework |
| **SQLAlchemy** | SQL Toolkit and Object-Relational Mapper (ORM) |
| **PostgreSQL** | Relational database storage |
| **Pydantic** | Strict data validation and serialization |
| **bcrypt** | Secure password hashing |
| **PyJWT** | JSON Web Token creation & parsing |
| **Cloudinary** | Image & audio storage and delivery CDN |
| **python-multipart** | Handling multipart form requests for file uploads |
| **Uvicorn** | ASGI server implementation |

---

## 🛠️ Setup & Configuration

### 1. Configure the Environment (`.env`)

Create a `.env` file in the `backend/` directory with the following variables:

```env
CLOUDINARY_CLOUD_NAME=your_cloudinary_cloud_name
CLOUDINARY_API_KEY=your_cloudinary_api_key
CLOUDINARY_API_SECRET=your_cloudinary_api_secret
```

### 2. Configure the Database

1. Ensure PostgreSQL is installed and running.
2. Create a database:
   ```sql
   CREATE DATABASE spotify_clone;
   ```
3. Update `DATABASE_URL` in `database.py` with your database credentials:
   ```python
   DATABASE_URL = "postgresql://<username>:<password>@localhost:5432/spotify_clone"
   ```

### 3. Run the Server

```bash
# Activate your virtual environment (venv)
# Windows:
python -m venv venv
venv\Scripts\activate
# macOS/Linux:
python3 -m venv venv
source venv/bin/activate

# Install requirements
pip install -r requirements.txt

# Run server locally
uvicorn main:app --reload
```

---

## 📡 API Endpoints

### 1. Authentication (`/auth`)

#### `POST /auth/signup`
Registers a new user.
* **Request Body (JSON):**
  ```json
  {
    "name": "Jane Doe",
    "email": "jane@example.com",
    "password": "strongpassword"
  }
  ```
* **Success Response (`201 Created`):** Returns the created user object.

#### `POST /auth/login`
Authenticates a user and generates a JWT.
* **Request Body (JSON):**
  ```json
  {
    "email": "jane@example.com",
    "password": "strongpassword"
  }
  ```
* **Success Response (`200 OK`):**
  ```json
  {
    "token": "JWT_TOKEN_STRING",
    "user": {
      "id": "uuid-string",
      "name": "Jane Doe",
      "email": "jane@example.com"
    }
  }
  ```

#### `GET /auth/`
Fetches current user's profile and lists their favorites.
* **Headers:** `x-auth-token: <token>`
* **Success Response (`200 OK`):** Returns the user object with nested favorites list.

---

### 2. Songs & Actions (`/song`)

#### `POST /song/upload`
Uploads a song and its thumbnail to Cloudinary.
* **Headers:** `x-auth-token: <token>`
* **Request Body (Multipart Form):**
  * `song` (File): Audio track file.
  * `thumbnail` (File): Image file for the cover.
  * `artist` (String): Artist name.
  * `song_name` (String): Name of the song.
  * `hex_code` (String): Dominant color hex string (for custom player backgrounds).
* **Success Response (`201 Created`):** Returns the created Song database object containing Cloudinary URLs.

#### `GET /song/list`
Lists all uploaded songs.
* **Headers:** `x-auth-token: <token>`
* **Success Response (`200 OK`):** List of all Song objects.

#### `POST /song/favorite`
Toggles favorite status for a song. If already favorited, it will be unfavorited.
* **Headers:** `x-auth-token: <token>`
* **Request Body (JSON):**
  ```json
  {
    "song_id": "song-uuid-string"
  }
  ```
* **Success Response (`200 OK`):**
  ```json
  {
    "message": true  // true if favorited, false if unfavorited
  }
  ```

#### `GET /song/list/favorites`
Lists all favorited songs of the authenticated user.
* **Headers:** `x-auth-token: <token>`
* **Success Response (`200 OK`):** Array of favorite song relations.

---

## 🗄️ Database Schemas

### `users` Table
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `TEXT` | Primary key (UUID string) |
| `name` | `VARCHAR(100)` | User's display name |
| `email` | `VARCHAR(100)` | Unique registered email |
| `password` | `LargeBinary` | bcrypt-hashed password bytes |

### `songs` Table
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `TEXT` | Primary key (UUID string) |
| `song_url` | `TEXT` | Cloudinary audio secure link |
| `thumbnail_url` | `TEXT` | Cloudinary thumbnail secure link |
| `artist` | `TEXT` | Song artist |
| `song_name` | `VARCHAR(100)` | Song title |
| `hex_code` | `VARCHAR(20)` | Custom player accent color |

### `favorites` Table
| Column | Type | Description |
| :--- | :--- | :--- |
| `id` | `TEXT` | Primary key (UUID string) |
| `song_id` | `TEXT` | Foreign key referencing `songs.id` |
| `user_id` | `TEXT` | Foreign key referencing `users.id` |

---

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).