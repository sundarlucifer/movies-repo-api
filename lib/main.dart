import 'package:flutter/material.dart';
import 'package:movies_repo/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Repo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff6200EE),
        primaryColorDark: Color(0xff3700B3),
        highlightColor: Color(0xff03DAC6),
        backgroundColor: Colors.white,
        errorColor: Color(0xffB00020),
      ),
      home: HomeScreen(),
    );
  }

}