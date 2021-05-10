import 'package:flutter/material.dart';
import 'package:flutter_app_movie/Screens/LandingPage.dart';
import 'package:flutter_app_movie/Screens/MovieDetail.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandinPage(),

      routes: {
        //'/landingPage': (context) => LandinPage(),
        '/movieDetails': (context) => MovieDetail(),
      },
    );
  }
}
