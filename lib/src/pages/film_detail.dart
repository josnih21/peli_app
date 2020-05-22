import 'package:flutter/material.dart';
import 'package:peli_app/src/models/film_model.dart';

class FilmDetail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Film pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppBar(pelicula),
        ],
      )
    );
  }

  Widget _crearAppBar(Film pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(pelicula.title,
        style: TextStyle(color: Colors.white,fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage(pelicula.getBackgroundImg()),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover,
          ),
      ),
    );
  }
}