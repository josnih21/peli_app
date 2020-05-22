import 'package:flutter/material.dart';

import 'package:peli_app/src/pages/home_page.dart';
import 'package:peli_app/src/pages/film_detail.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detail' : (BuildContext context) => FilmDetail(),
      },
    );
  }
}