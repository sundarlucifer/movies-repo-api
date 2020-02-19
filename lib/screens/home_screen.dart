import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _movieTitle = '';

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _getLogo(),
                _getHeaderText(),
              ],
            ),
            Container(
              width: 500,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _getSearchField(),
                  _getSearchButton(),
                ],
              ),
            ),
          ],
        ),
        _getLoadingAnimation(),
      ],),
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
      width: 300.0,
      child: TextField(
        // autofocus: true, TODO: use only for web
        showCursor: false,
        decoration: InputDecoration(
          hintText: 'Type title of movie',
          hintStyle: TextStyle(color: Colors.black38),
        ),
        onSubmitted: (title) {
          _movieTitle = title;
          _searchMovie();
        },
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
      onPressed: () => _searchMovie(),
    );
  }

  _searchMovie() {
    print('getMovie() called title = ' + _movieTitle);
    if (_movieTitle.isNotEmpty) {
      setState(() {
        _isLoading = true;
        print('set loading to true');
      });

      setState(() {
        // _isLoading = false;
      });
    }
  }

  _getLoadingAnimation() {
    print('loading ? ' + _isLoading.toString());
    return _isLoading ? Center(
      child: CircularProgressIndicator(),
    ) : Center();
  }
}
