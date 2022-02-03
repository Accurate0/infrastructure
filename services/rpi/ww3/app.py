import json
from flask import Flask, request, jsonify
from flask_cors import cross_origin

app = Flask(__name__)
app.url_map.strict_slashes = False

prefix = ""
if app.env == "development":
    prefix = "/api"


@app.route(f"{prefix}/check", methods=["GET"])
@cross_origin()
def get():
    return jsonify(
        {
            "ww3": "No",
        }
    )
