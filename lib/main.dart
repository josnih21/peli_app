import 'package:flutter/material.dart';

import 'package:peli_app/src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        '/' : (BuildContext context) => HomePage(),
      },
    );
  }
}