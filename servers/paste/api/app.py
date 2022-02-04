import redis
import hashlib
import base64
from datetime import datetime
from flask import Flask, request, jsonify

app = Flask(__name__)
app.url_map.strict_slashes = False

prefix = ''
redis_host = 'redis'
if app.env == 'development':
    prefix = '/api'
    redis_host = 'localhost'

cache = redis.Redis(host=redis_host, port=6379)

HOUR = 3600


@app.route(f"{prefix}/<string:uid>", methods=['GET'])
def get(uid):
    if(cache.exists(uid)):
        raw_data = cache.hgetall(uid)
        data = {k.decode('utf-8'): raw_data[k].decode('utf-8') for k in raw_data}
        data['expire'] = cache.ttl(uid)
        return jsonify(data), 200
    else:
        return '', 404


@app.route(f"{prefix}/", methods=['POST'])
def create_new():
    data = request.form.get('paste')
    if data is None:
        return '', 400

    # im going to prison for this one
    m = hashlib.sha1()
    m.update(data.encode('utf-8') + bytes(datetime.now().microsecond))
    uid = m.hexdigest()[:10]

    full_data = {
        "paste": data
    }

    if request.form.get('language') is not None:
        full_data['language'] = request.form['language']

    if request.form.get('filename') is not None:
        full_data['filename'] = request.form['filename']

    cache.hmset(uid, full_data)
    cache.expire(uid, 8 * HOUR)

    return jsonify(uid=uid, expires=8 * HOUR), 200
