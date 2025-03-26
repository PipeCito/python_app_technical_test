import pytest
from app import app


@pytest.fixture
def client():
    app.testing = True
    return app.test_client()


def test_root(client):
    response = client.get("/")
    assert response.status_code == 200
    assert response.data == b"Customer Feedback API"


def test_create_feedback(client):
    response = client.post(
        "/feedback",
        json={"id": "1", "customer_name": "Alice", "comments": "Great service!"},
    )
    assert response.status_code == 201
