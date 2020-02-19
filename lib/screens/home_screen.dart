import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image(
                  height: 100.0,
                  width: 100.0,
                  image: AssetImage('assets/images/movie_01.png'),
                ),
                Text(
                  'Movies Repo',
                  style: TextStyle(
                    fontSize: 50.0,
                    // color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Container(
              width: 500,
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                // boxShadow: [
                //   BoxShadow(
                //     blurRadius: 6.0,
                //     offset: Offset(1, 0),
                //     color: Colors.black12,
                //   ),
                // ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 300.0,
                    child: TextField(
                      showCursor: false,
                      onSubmitted: (String title){},
                      decoration: InputDecoration(
                          hintText: 'Type title of movie',
                          hintStyle: TextStyle(color: Colors.black38)),
                    ),
                  ),
                  FlatButton(
                    color: Theme.of(context).highlightColor,
                    child: Text(
                      'SEARCH',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
