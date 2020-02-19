from flask import Flask, render_template

app = Flask(__name__)
app.config['DEBUG'] = True

@app.route('/')
def home():
    return {
        'success': False,
        'message': 'Search query \'title\' required',
    }

@app.errorhandler(404)
def error():
    return {
        'success': False,
        'message': 'Invalid request',
    }

app.run()
