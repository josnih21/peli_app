import 'package:flutter/material.dart';
import 'package:peli_app/src/search/search_delegate.dart';

import 'package:peli_app/src/widgets/card_swiper_widget.dart';
import 'package:peli_app/src/providers/films_providers.dart';
import 'package:peli_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {
    filmsProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch(),
              );
            }
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTajertas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTajertas() {
    return FutureBuilder(
      future: filmsProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(films: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Populares', style: Theme.of(context).textTheme.subhead),
            StreamBuilder(
              stream: filmsProvider.popularsStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if(snapshot.hasData){
                return MovieHorizontal(films: snapshot.data, nextPage: filmsProvider.getPopular);
                }else{
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ));
  }
}
