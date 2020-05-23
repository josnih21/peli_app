import 'package:flutter/material.dart';
import 'package:peli_app/src/models/film_model.dart';
import 'package:peli_app/src/providers/films_providers.dart';

class DataSearch extends SearchDelegate{

  final filmsProvider = FilmsProvider();

  final peliculas = [
    'Kill bill',
    'Blade Runner',
    'Sin City',
    'Ciudad de Dios',
    'Blade Runner 2049',
    'Mass Effect: Paragon Lost',
    'Borat',
    'The End of Evangelion'
  ];

  final peliculasRecientes =  [
    'Spiderman',
    'Capitan america',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Appbar actions
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: (){
          query = '';
        }
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon to left of appbar
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow
      ), 
      onPressed: (){
        close(context, null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // create showed results
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // sugerencias de busqueda
    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: filmsProvider.searchFilm(query),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if(snapshot.hasData){
          return ListView(
            children: snapshot.data.map((film){
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'), 
                  image: NetworkImage(film.getPosterImg()),
                  fit: BoxFit.contain,
                ),
                title: Text(film.title),
                subtitle: Text(film.originalTitle),
                onTap: (){
                  close(context,null);
                  film.uniqueId = '';
                  Navigator.pushNamed(context, 'detail',arguments: film);
                },
              );
            }).toList()
          ); 
        }else{
          return Center(
            child: CircularProgressIndicator()
          );
        }
      },
    );
  }

//@override
//  Widget buildSuggestions(BuildContext context) {
//    // sugerencias de busqueda
//
//    final suggestedList = (query.isEmpty) ? peliculasRecientes 
//                                             : peliculas.where(
//                                               (p) => p.toLowerCase().startsWith(query.toLowerCase())
//                                               ).toList(); 
//    return ListView.builder(
//      itemCount: suggestedList.length,
//      itemBuilder: (context,i){
//        return ListTile(
//          leading: Icon(Icons.movie),
//          title: Text(suggestedList[i]),
//          onTap: (){
//
//          },
//        );
//      },
//    );
//  }
}