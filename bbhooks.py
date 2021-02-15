from flask import Flask, request, Response
import os

app = Flask(__name__)

@app.route(os.environ.get('BBHOOKS_PATH'), methods=['POST'])
def respond():
    print(request.json);
    return Response(status=200)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=os.environ.get('BBHOOKS_PORT'))
