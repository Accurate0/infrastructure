from flask import Flask, request

app = Flask(__name__)
app.url_map.strict_slashes = False

@app.route("/", methods=['GET', 'POST'])
def Paste():
    print(request.data)
    return '', 200
