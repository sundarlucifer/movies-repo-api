import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:movies_repo/models/movie.dart';
import 'package:movies_repo/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _smallScreen = false;
  String _errorMessage = '';

  bool _isLoading = false;
  Movie _movie;

  TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _smallScreen = MediaQuery.of(context).size.width < 500;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _getPage(),
          _getLoadingAnimation(),
        ],
      ),
    );
  }

  _getPage() {
    List<Widget> headerAndSearch = [
      _getHeader(),
      Column(
        children: <Widget>[
          Container(
            width: _smallScreen ? 300 : 500,
            height: _smallScreen ? 150 : 100.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: _smallScreen
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _getSearchField(),
                      SizedBox(
                        height: 20.0,
                      ),
                      _getSearchButton(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _getSearchField(),
                      _getSearchButton(),
                    ],
                  ),
          ),
          _getErrorMessage(),
        ],
      ),
    ];

    return _movie == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: headerAndSearch,
          )
        : ListView(
            children: headerAndSearch + [_getMovieCard()],
          );
  }

  _getHeader() {
    return _smallScreen
        ? Center(
            child: Column(
              children: <Widget>[
                _getLogo(),
                _getHeaderText(),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _getLogo(),
              _getHeaderText(),
            ],
          );
  }

  _getLogo() {
    return Image(
      height: 100.0,
      width: 100.0,
      image: AssetImage('assets/images/movie_01.png'),
    );
  }

  _getHeaderText() {
    return Text(
      'Movies Repo',
      style: TextStyle(
        fontSize: 50.0,
        // color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _getSearchField() {
    return Container(
      width: _smallScreen ? 200.0 : 300.0,
      child: TextField(
        controller: _textController,
        autofocus: true,
        showCursor: false,
        decoration: InputDecoration(
          hintText: 'Type title of movie',
          hintStyle: TextStyle(color: Colors.black38),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => _textController.clear(),
          ),
        ),
        onSubmitted: (title) => _searchMovie(title),
      ),
    );
  }

  _getSearchButton() {
    return FlatButton(
      color: Theme.of(context).highlightColor,
      child: Text(
        'SEARCH',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      onPressed: () => _searchMovie(_textController.text),
    );
  }

  _getErrorMessage() {
    return _errorMessage.isEmpty
        ? SizedBox(height: 0)
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              _errorMessage,
              style: TextStyle(
                color: Theme.of(context).errorColor,
              ),
            ),
          );
  }

  _getMovieCard() {
    return _movie == null
        ? SizedBox(
            height: 0,
          )
        : Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Image(
                  image: NetworkImage(_movie.posterUrl),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  _movie.title,
                  style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text('Trailer'),
                Linkify(
                    onOpen: (url) async {
                      if (await canLaunch(_movie.trailerUrl)) {
                        await launch(_movie.trailerUrl);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    text: _movie.trailerUrl),
                SizedBox(height: 40),
                FlatButton(
                  child: Text('Clear'),
                  onPressed: () {
                    setState(() {
                      _movie = null;
                    });
                  },
                ),
              ],
            ),
          );
  }

  _searchMovie(String movieTitle) async {
    if (movieTitle.isNotEmpty) {
      setState(() {
        _errorMessage = '';
        _isLoading = true;
        _movie = null;
      });

      APIService.instance.searchMovie(movieTitle).then((movie) {
        print('then');
        setState(() {
          _isLoading = false;
          print(movie);
          _movie = movie;
          _textController.text = movieTitle;
        });
      }).catchError((error) {
        print(error);

        setState(() {
          _errorMessage = error.toString();
          _isLoading = false;
        });
      });
    }
  }

  _getLoadingAnimation() {
    return _isLoading
        ? Container(
            color: Color.fromRGBO(100, 100, 100, 0.1),
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
              ),
            ),
          )
        : Center();
  }
}
