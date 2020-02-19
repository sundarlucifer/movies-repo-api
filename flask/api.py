from flask import Flask, render_template, request, jsonify

app = Flask(__name__)
app.config['DEBUG'] = True

movies = {
    'matrix': {
        'title': 'The Matrix',
        'trailerUrl': 'https://www.youtube.com/watch?v=m8e-FF8MsqU',
        'posterUrl': 'https://upload.wikimedia.org/wikipedia/en/c/c1/The_Matrix_Poster.jpg',
    },
}

@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', '*')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type,Authorization')
    response.headers.add('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
    return response

@app.route('/')
def home():
    return jsonify({
        'success': False,
        'message': 'Search query \'title\' required',
        'syntax': '<url>/movies/search?title=<movie-title>',
        'example': '<url>/movies/search?title=matrix',
    }), 400

@app.errorhandler(404)
def error():
    return jsonify({
        'success': False,
        'message': 'Invalid request',
    }), 404

@app.route('/movies/search', methods=['GET', 'POST', 'OPTIONS'])
def searchMovie():
    movieTitle = request.args.get('title')
    if movieTitle in movies:
        return jsonify({
            'success': True,
            'message': 'movie found',
            'movie': movies[movieTitle],
        }), 200
    return jsonify({
        'success': False,
        'message': 'movie not found',
    }), 200

app.run()
