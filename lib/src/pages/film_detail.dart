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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitle(context,pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                _description(pelicula),
                
              ]
            )
          )
        ],
      )
    );
  }

  Widget _crearAppBar(Film pelicula) {
    return SliverAppBar(
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
          fit: BoxFit.cover,
          ),
      ),
    );
  }

 Widget _posterTitle(BuildContext context,Film pelicula) {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
       children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: 
          Image(
            height: 150.0,
            image: NetworkImage(pelicula.getPosterImg()),
          ),
        ),
        SizedBox(width:20.0),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(pelicula.title,style: Theme.of(context).textTheme.title,overflow: TextOverflow.ellipsis,),
              Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle,overflow: TextOverflow.ellipsis,),
              Row(
                children: <Widget>[
                  Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subtitle,overflow: TextOverflow.ellipsis)
                ],
              )
            ],
          )
        )
       ],
    )
   );
 }

  Widget _description(Film pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical:20.0),
      child: Text(pelicula.overview,textAlign: TextAlign.justify,)
    );
  }
}