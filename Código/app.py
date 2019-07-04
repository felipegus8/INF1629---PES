from flask import Flask, request, abort, jsonify
from flask_cors import CORS

import simplejson as json
from crypto_predictions import get_predictions

app = Flask(__name__)
CORS(app)

@app.route("/")
def all_coins():
    result = {
        'BTC': get_predictions('BTC'),
        'XRP': get_predictions('XRP'),
        'XMR': get_predictions('XMR')
    }
    return jsonify(result), 200

@app.route("/<coin>")
def specific(coin=None):
    if coin is None:
        return jsonify({'error': 'coin not specified'}), 404
    coin_name = coin.upper()
    if coin_name != 'BTC' and coin_name != 'XRP' and coin_name != 'XMR':
        return jsonify({'error': 'coin not implemented'}), 501
  
    result = get_predictions(coin_name.upper())
    return jsonify(result), 200


if __name__ == '__main__':
    app.run(threaded=True, debug=True)