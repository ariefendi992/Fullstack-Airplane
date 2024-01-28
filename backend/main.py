from app import create_app
from werkzeug.serving import WSGIRequestHandler
import os

app = create_app()
print(app.config.get("SERVER_PROTOCOL"))
if __name__ == "__main__":
    WSGIRequestHandler.protocol_version = "HTTP/1.1"
    app.run(host="0.0.0.0", debug=True)
5
