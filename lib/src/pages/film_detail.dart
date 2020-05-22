import 'package:flutter/material.dart';
import 'package:peli_app/src/models/actors_model.dart';
import 'package:peli_app/src/models/film_model.dart';
import 'package:peli_app/src/providers/films_providers.dart';

class FilmDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Film pelicula = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppBar(pelicula),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10.0,
          ),
          _posterTitle(context, pelicula),
          _description(pelicula),
          _description(pelicula),
          _description(pelicula),
          _description(pelicula),
          _description(pelicula),
          _description(pelicula),
          _createCasting(pelicula),
        ]))
      ],
    ));
  }

  Widget _crearAppBar(Film pelicula) {
    return SliverAppBar(
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Film pelicula) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                height: 150.0,
                image: NetworkImage(pelicula.getPosterImg()),
              ),
            ),
            SizedBox(width: 20.0),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pelicula.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  pelicula.originalTitle,
                  style: Theme.of(context).textTheme.subtitle,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle,
                        overflow: TextOverflow.ellipsis)
                  ],
                )
              ],
            ))
          ],
        ));
  }

  Widget _description(Film pelicula) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Text(
          pelicula.overview,
          textAlign: TextAlign.justify,
        ));
  }

  Widget _createCasting(Film pelicula) {
    final filmProvider = new FilmsProvider();

    return FutureBuilder(
      future: filmProvider.getCast(pelicula.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        itemBuilder: (context, i) {
          return _actorCard(actores[i]);
        },
        itemCount: actores.length,
         
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(image: NetworkImage(actor.getPhotoImg()),placeholder: AssetImage('assets/loading.gif'),height: 150.0,fit: BoxFit.cover,)
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis)         
        ],
      ),
    );
  }
}
