from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "<h1>Jacob Rowe</h1><br><p>UVID: 11072082</p>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)