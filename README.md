# Flask TODO App

A lightweight task manager built with **Flask**, **Jinja2 templates**, and **TinyDB**.
This project is designed as a beginner-friendly example of a CRUD-style web app where you can:

- Add tasks
- Edit existing tasks
- Mark tasks as complete
- Delete tasks

The application persists data in a local JSON database (`db.json`) and renders everything through a single template (`templates/index.html`).

---

## Table of Contents

- [Project Overview](#project-overview)
- [How the Application Works](#how-the-application-works)
  - [Backend (`app.py`)](#backend-apppy)
  - [Frontend (`templates/index.html`)](#frontend-templatesindexhtml)
  - [Database (`db.json`)](#database-dbjson)
- [HTTP Routes and Behavior](#http-routes-and-behavior)
- [Project Structure](#project-structure)
- [Requirements](#requirements)
- [Setup Instructions](#setup-instructions)
- [How to Run the Web Application](#how-to-run-the-web-application)
- [Usage Guide](#usage-guide)
- [Notes and Limitations](#notes-and-limitations)
- [Screenshots](#screenshots)

---

## Project Overview

This Flask TODO app is a minimal full-stack example that demonstrates:

1. **Server-side rendering** with Flask + Jinja2.
2. **Form handling** (`POST` requests) for creating and updating tasks.
3. **State-changing links** for completing and deleting tasks.
4. **Persistent local storage** using TinyDB.

Each task is stored with three fields:

- `id` (integer): randomly generated task identifier.
- `title` (string): task text entered by the user.
- `complete` (boolean): task completion status.

---

## How the Application Works

### Backend (`app.py`)

The Flask app initializes in `app.py` and connects to TinyDB:

- `app = Flask(__name__)` creates the Flask application instance.
- `db = TinyDB('db.json')` creates/opens the local JSON database file.

Core flow:

1. User opens `/`.
2. Backend reads all tasks from TinyDB.
3. Backend renders `index.html` and passes `todo_list` into the template.
4. User actions (add/update/complete/delete) trigger requests to dedicated routes.
5. Routes modify TinyDB, then redirect back to `/`.

### Frontend (`templates/index.html`)

The template is responsible for:

- Rendering the add-task form.
- Looping over `todo_list` and showing each task.
- Styling pending vs completed tasks differently.
- Triggering backend routes via links/buttons.
- Showing a popup form for editing a task title.
- Displaying a live datetime element via JavaScript.

UI behavior:

- **Incomplete tasks** show complete, edit, and delete actions.
- **Completed tasks** are displayed with strikethrough and a different background.
- **Edit** opens a popup, pre-fills the task title, and sends updated text to `/update`.

### Database (`db.json`)

TinyDB stores records in `db.json` in JSON format.

Example document shape:

```json
{
  "id": 123,
  "title": "Read Flask docs",
  "complete": false
}
```

No external database server is required.

---

## HTTP Routes and Behavior

| Route | Method | Purpose | Action |
|---|---|---|---|
| `/` | GET | Home page | Reads all tasks and renders `index.html` |
| `/add` | POST | Add task | Inserts new record with random `id`, given `title`, `complete=False` |
| `/update` | POST | Update title | Updates `title` by matching submitted `hiddenField` id |
| `/delete/<int:todo_id>` | GET | Delete task | Removes matching record from TinyDB |
| `/complete/<int:todo_id>` | GET | Complete task | Sets `complete=True` for matching record |

All mutating routes redirect to `/` after execution.

---

## Project Structure

```text
Flask-TODO-APP-imp-/
├── app.py
├── db.json
├── requirements.txt
├── README.md
├── templates/
│   └── index.html
└── screenshot/
    ├── Home.png
    ├── Task_creation.png
    ├── UpdateTodo.png
    └── update_delete.png
```

---

## Requirements

- Python 3.8+ (recommended)
- `pip`

Python packages (from `requirements.txt`):

- `Flask`
- `tinydb`

Install with:

```bash
pip install -r requirements.txt
```

---

## Setup Instructions

1. **Clone the repository**

   ```bash
   git clone <your-repo-url>
   cd Flask-TODO-APP-imp-
   ```

2. **Create and activate a virtual environment** (recommended)

   macOS/Linux:

   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```

   Windows (PowerShell):

   ```powershell
   python -m venv .venv
   .venv\Scripts\Activate.ps1
   ```

3. **Install dependencies**

   ```bash
   pip install -r requirements.txt
   ```

---

## How to Run the Web Application

### Option 1: Run directly with Python

```bash
python app.py
```

This starts Flask with `debug=True` (as configured in `app.py`).

### Option 2: Run with Flask CLI

macOS/Linux:

```bash
export FLASK_APP=app.py
flask run
```

Windows (PowerShell):

```powershell
$env:FLASK_APP = "app.py"
flask run
```

Once running, open your browser at:

- `http://127.0.0.1:5000/`

---

## Usage Guide

1. **Add a task**
   - Enter text in “Add Your Task Here”.
   - Click the `+` button.

2. **Mark a task complete**
   - Click the check icon next to an incomplete task.

3. **Update a task title**
   - Click the pencil icon.
   - Edit text in the popup.
   - Click **Update** to submit.

4. **Delete a task**
   - Click the trash icon.

---

## Notes and Limitations

- Task IDs are generated with `random.randint(0, 1000)`, so collisions are possible in edge cases.
- `/complete` only sets `complete=True`; there is no “mark incomplete” route.
- Update and delete actions rely on task IDs being unique.
- Data is stored locally in `db.json`; this is ideal for learning and small demos, not production-scale workloads.

---

## Screenshots

### Home

![Home](screenshot/Home.png)

### Task Creation

![Task Creation](screenshot/Task_creation.png)

### Task Update

![Task Update](screenshot/UpdateTodo.png)

### Update/Delete Example

![Update Delete](screenshot/update_delete.png)
