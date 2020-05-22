import 'package:flutter/material.dart';
import 'package:peli_app/src/models/film_model.dart';

class FilmDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Film pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body:Center(child:Text(pelicula.title)),
    );
  }
}