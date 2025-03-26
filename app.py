from flask import Flask, jsonify, request

app = Flask(__name__)

feedbacks = {
  "000":{
    "comments": "Great service!",
    "customer_name": "Alice",
    "id": "000"
  },
  "007":{
    "comments": "Its Okey.",
    "customer_name": "James Bond",
    "id": "007"
  },
  "123":{
    "comments": "Very good!",
    "customer_name": "Andres Monje",
    "id": "123"
  }
}

# root endpoint
@app.route("/")
def root():
    return "Customer Feedback API", 200

# GET - get feedbacks
@app.route("/feedbacks", methods=["GET"])
def get_feedbacks():
  return jsonify(feedbacks), 200

# GET - get feedback for ID
@app.route("/feedback/<feedback_id>", methods=["GET"])
def get_feedback(feedback_id):
    feedback = feedbacks.get(feedback_id)
    if feedback:
        return jsonify(feedback), 200
    return jsonify({"error": "Feedback not found"}), 404

# POST - create a new feedback
@app.route("/feedback", methods=["POST"])
def create_feedback():
    data = request.get_json()
    feedback_id = str(data.get("id"))
    if not feedback_id or "customer_name" not in data or "comments" not in data:
        return jsonify({"error": "ID, customer_name, and comments are required"}), 400
    feedbacks[feedback_id] = data
    return jsonify({"message": "Feedback submitted", "feedback": data}), 201

# PUT - update feedback
@app.route("/feedback/<feedback_id>", methods=["PUT"])
def update_feedback(feedback_id):
    if feedback_id not in feedbacks:
        return jsonify({"error": "Feedback not found"}), 404
    data = request.get_json()
    feedbacks[feedback_id].update(data)
    return (
        jsonify({"message": "Feedback updated", "feedback": feedbacks[feedback_id]}),
        200,
    )

# DELETE - delete feedback
@app.route("/feedback/<feedback_id>", methods=["DELETE"])
def delete_feedback(feedback_id):
    if feedback_id not in feedbacks:
        return jsonify({"error": "Feedback not found"}), 404
    del feedbacks[feedback_id]
    return jsonify({"message": "Feedback deleted"}), 200


if __name__ == "__main__":
    app.run(port=5000,host='0.0.0.0',debug=True)
