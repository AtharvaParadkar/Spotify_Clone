# 🎵 Spotify Clone — Full Stack

A full-stack Spotify-inspired music streaming application built with **Flutter** on the frontend and **FastAPI + PostgreSQL** on the backend.

---

## 🗂️ Project Structure

```
Spotify_Clone/
├── frontend/        # Flutter mobile/desktop application
├── backend/         # Python FastAPI REST API
└── README.md        # You are here
```

---

## 🚀 Tech Stack

| Layer       | Technology                          |
|-------------|-------------------------------------|
| Frontend    | Flutter (Dart)                      |
| Backend     | Python, FastAPI                     |
| Database    | PostgreSQL                          |
| ORM         | SQLAlchemy                          |
| Auth        | bcrypt password hashing             |

---

## ✨ Features

- 🔐 **User Authentication** — Sign up and sign in with secure bcrypt-hashed passwords
- 🎨 **Dark Theme UI** — Spotify-inspired dark mode with gradient accents
- 📱 **Cross-Platform** — Runs on Android, iOS, Web, Windows, macOS, and Linux
- 🔗 **RESTful API** — Clean API endpoints powered by FastAPI
- 🗄️ **PostgreSQL Database** — Persistent storage for users and (upcoming) music data

---

## 🛠️ Getting Started

### Prerequisites

Make sure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Dart SDK `^3.10.3`)
- [Python 3.10+](https://www.python.org/downloads/)
- [PostgreSQL](https://www.postgresql.org/download/)

---

### 1. Clone the Repository

```bash
git clone https://github.com/AtharvaParadkar/Spotify_Clone.git
cd Spotify_Clone
```

---

### 2. Set Up the Backend

> See [`backend/README.md`](./backend/README.md) for full backend setup instructions.

```bash
cd backend
python -m venv venv
venv\Scripts\activate        # Windows
# source venv/bin/activate   # macOS/Linux
pip install -r requirements.txt
uvicorn main:app --reload
```

---

### 3. Set Up the Frontend

> See [`frontend/README.md`](./frontend/README.md) for full frontend setup instructions.

```bash
cd frontend
flutter pub get
flutter run
```

---

## 📡 API Overview

| Method | Endpoint   | Description             |
|--------|------------|-------------------------|
| POST   | `/signup`  | Register a new user     |
| POST   | `/signin`  | Authenticate a user     |

The API runs at `http://localhost:8000` by default. Interactive docs are available at `http://localhost:8000/docs`.

---

## 📸 Screenshots

> *(Coming soon — add screenshots of the app here)*

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to open a pull request or file an issue.

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

> Built with ❤️ by [Atharva Paradkar](https://github.com/AtharvaParadkar)
