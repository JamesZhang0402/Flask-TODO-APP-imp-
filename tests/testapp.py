from pathlib import Path
import sys

import pytest
from tinydb import Query, TinyDB

sys.path.append(str(Path(__file__).resolve().parents[1]))
import app as todo_app


@pytest.fixture()
def client(tmp_path, monkeypatch):
    test_db_path = tmp_path / "test_db.json"
    test_db = TinyDB(test_db_path)

    monkeypatch.setattr(todo_app, "db", test_db)
    todo_app.app.config["TESTING"] = True

    with todo_app.app.test_client() as client:
        yield client

    test_db.close()


def test_main_page_loads_successfully(client):
    response = client.get("/")

    assert response.status_code == 200
    assert b"To Do List" in response.data


def test_add_new_task(client):
    response = client.post("/add", data={"title": "Write pytest tests"}, follow_redirects=True)

    assert response.status_code == 200
    assert b"Write pytest tests" in response.data

    todo_query = Query()
    saved_task = todo_app.db.search(todo_query.title == "Write pytest tests")
    assert len(saved_task) == 1


def test_delete_existing_task(client):
    task_id = 999
    todo_app.db.insert({"id": task_id, "title": "Task to delete", "complete": False})

    response = client.get(f"/delete/{task_id}", follow_redirects=True)

    assert response.status_code == 200
    assert b"Task to delete" not in response.data

    todo_query = Query()
    remaining_task = todo_app.db.search(todo_query.id == task_id)
    assert remaining_task == []
