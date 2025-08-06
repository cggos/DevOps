# flask --app hello run or python app.py
# curl http://localhost:8000

from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "<p>Hello, World!</p>"

@app.route("/moco")
def moco():
    return "Hello moco!"

if __name__ == "__main__":
    app.run()
    # app.run(host='0.0.0.0', port=8000)
