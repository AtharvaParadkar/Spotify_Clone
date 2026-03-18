# ⚙️ Spotify Clone — Backend

The backend for the Spotify Clone project, built with **Python**, **FastAPI**, and **PostgreSQL**. It exposes a RESTful API for user authentication and will expand to handle music, playlists, and streaming data.

---

## 🗂️ Project Structure

```
backend/
├── main.py          # FastAPI application entry point
├── venv/            # Python virtual environment (not committed)
└── README.md        # You are here
```

---

## 🚀 Tech Stack

| Technology     | Purpose                              |
|----------------|--------------------------------------|
| FastAPI        | High-performance async REST API      |
| SQLAlchemy     | ORM for database interaction         |
| PostgreSQL     | Relational database                  |
| Pydantic       | Request/response data validation     |
| bcrypt         | Secure password hashing              |
| Uvicorn        | ASGI server to run FastAPI           |

---

## ✨ API Endpoints

| Method | Endpoint  | Description                    | Auth Required |
|--------|-----------|--------------------------------|---------------|
| POST   | `/signup` | Register a new user            | No            |

### `POST /signup`

Registers a new user with a hashed password.

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "yourpassword"
}
```

**Success Response (`200 OK`):**
```json
{
  "id": "uuid-string",
  "name": "John Doe",
  "email": "john@example.com"
}
```

**Error Response (`400 Bad Request`):**
```json
{
  "detail": "User already exists with same email"
}
```

---

## 🛠️ Setup & Installation

### Prerequisites

- [Python 3.10+](https://www.python.org/downloads/)
- [PostgreSQL](https://www.postgresql.org/download/) installed and running

---

### 1. Create a Virtual Environment

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# macOS / Linux
python3 -m venv venv
source venv/bin/activate
```

---

### 2. Install Dependencies

```bash
pip install fastapi uvicorn sqlalchemy psycopg2-binary pydantic bcrypt
```

> 💡 **Tip:** Generate a `requirements.txt` for easier installs:
> ```bash
> pip freeze > requirements.txt
> # Later, install via:
> pip install -r requirements.txt
> ```

---

### 3. Configure the Database

Make sure PostgreSQL is running and create a database:

```sql
CREATE DATABASE spotify_clone;
```

Then update the `DATABASE_URL` in `main.py` with your credentials:

```python
DATABASE_URL = "postgresql://<username>:<password>@localhost:5432/spotify_clone"
```

---

### 4. Run the Server

```bash
uvicorn main:app --reload
uvicorn main:app --host 0.0.0.0 --port 8000 --reload
```

The API will be available at:

- **Base URL:** `http://localhost:8000`
- **Interactive Docs (Swagger UI):** `http://localhost:8000/docs`
- **ReDoc:** `http://localhost:8000/redoc`

---

## 🗄️ Database Schema

### `users` Table

| Column     | Type           | Description                     |
|------------|----------------|---------------------------------|
| `id`       | `TEXT` (UUID)  | Primary key, auto-generated UUID |
| `name`     | `VARCHAR(100)` | User's display name             |
| `email`    | `VARCHAR(100)` | User's unique email address     |
| `password` | `LargeBinary`  | bcrypt-hashed password          |

> Tables are auto-created on server start via `Base.metadata.create_all(bind=engine)`.

---

## 🔒 Security

- Passwords are **never stored in plain text** — they are hashed using `bcrypt` with a salt before being saved to the database.
- Duplicate email registration is rejected with a `400` error.

---

## 📌 Roadmap

- [ ] `POST /signin` — User login with JWT token generation
- [ ] `GET /songs` — Fetch available songs
- [ ] `POST /upload` — Upload songs (admin)
- [ ] `GET /playlists` — Fetch user playlists
- [ ] Token-based authentication middleware

---

## 📄 License

This project is open source and available under the [MIT License](../LICENSE).