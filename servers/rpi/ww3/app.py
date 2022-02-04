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
            "status": "No",
            "emoji": "😌",
        }
    )


@app.after_request
def add_header(response):
    response.cache_control.max_age = 2400
    response.cache_control.public = True
    return response
