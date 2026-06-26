# 🎵 Spotify Clone — Full Stack

A full-stack, cross-platform Spotify-inspired music streaming application. It features a stunning **Flutter** client on the frontend, powered by a robust and high-performance **FastAPI** backend with **PostgreSQL** relational database persistence and **Cloudinary** cloud media hosting.

---

## 🗂️ Project Structure

```text
Spotify_Clone/
├── frontend/        # Flutter mobile & desktop client application
├── backend/         # FastAPI Python REST API & database controllers
└── README.md        # Project overview and entry-point guide
```

---

## 🚀 Tech Stack

| Layer | Technology | Key Capabilities / Packages |
| :--- | :--- | :--- |
| **Frontend** | Flutter & Dart | Material 3, Riverpod State Management, Just Audio, Audio Waveforms, Hive |
| **Backend** | Python & FastAPI | Asynchronous requests, Pydantic data validation, JWT |
| **Database** | PostgreSQL | Relational storage for users, songs, and favorites |
| **ORM** | SQLAlchemy | Declarative models and relationships |
| **Media Host** | Cloudinary | Cloud storage and CDN streaming for audio & thumbnails |
| **Auth** | bcrypt & PyJWT | Password hashing, secure JWT state validation |

---

## ✨ Features

- 🔐 **Secure User Auth** — Registration and login with bcrypt password hashing and JWT token exchange.
- 🎵 **Audio Streaming & Control** — Play, pause, and seek tracks with a rich player interface. Supports background audio playback on mobile devices via `just_audio_background`.
- 🎨 **Visual Polish** — Gradient themes, dark mode aesthetics, interactive sliders, and color-matched track layouts.
- ☁️ **Media Cloud Upload** — Form-based uploads (audio file + cover thumbnail) stored on Cloudinary.
- 💖 **Favorite Library** — Toggle favorite status on tracks with persistent user-specific storage.
- 📦 **Offline Caching** — Local cache synchronization using Hive for fast load times and offline usability.
- 📱 **Cross-Platform Support** — Fully responsive and optimized UI running on Android, iOS, Web, Windows, macOS, and Linux.

---

## 🛠️ Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Dart SDK `^3.10.3`)
- [Python 3.10+](https://www.python.org/downloads/)
- [PostgreSQL](https://www.postgresql.org/download/)
- A [Cloudinary Account](https://cloudinary.com/) (for backend media uploads)

---

### 1. Clone the Repository

```bash
git clone https://github.com/AtharvaParadkar/Spotify_Clone.git
cd Spotify_Clone
```

---

### 2. Configure & Run Backend

For comprehensive setup details, environment keys, and DB configuration, refer to the [Backend README](./backend/README.md).

```bash
cd backend
python -m venv venv
venv\Scripts\activate        # Windows
# source venv/bin/activate   # macOS/Linux

pip install -r requirements.txt
uvicorn main:app --reload
```

---

### 3. Configure & Run Frontend

For details on local caching, asset directories, and state generation, see the [Frontend README](./frontend/README.md).

```bash
cd ../frontend
flutter pub get
flutter run
```

---

## 📡 API Overview

The backend service runs at `http://localhost:8000` by default. Swagger documentation is available at `/docs`.

### Authentication (`/auth`)
* `POST /auth/signup` — Registers a new user.
* `POST /auth/login` — Authenticates a user and returns a JWT token.
* `GET /auth/` — Returns the current user profile along with favorite songs.

### Songs & Actions (`/song`)
* `POST /song/upload` — Uploads a new song & cover art (admin/user).
* `GET /song/list` — Lists all available songs.
* `POST /song/favorite` — Toggles favorite status on a song for the current user.
* `GET /song/list/favorites` — Fetches the list of favorited songs for the current user.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to open a pull request or submit a new issue.

---

## 📄 License

This project is open-source and licensed under the [MIT License](LICENSE).

---
> Built with ❤️ by [Atharva Paradkar](https://github.com/AtharvaParadkar)
