import 'package:flutter/material.dart';

import 'package:peli_app/src/pages/widgets/card_swiper_widget.dart';
import 'package:peli_app/src/providers/films_providers.dart';

class HomePage extends StatelessWidget {
  final filmsProvider = new FilmsProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas cine'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){})
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _swiperTajertas(),
          ],
        ),
      ),
    );
  }

 Widget _swiperTajertas() {
  return FutureBuilder(
    future: filmsProvider.getNowPlaying(),
    builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
      if(snapshot.hasData){
        return CardSwiper(
          films: snapshot.data
        );
      }else{
        return Container(
          height: 400.0,
          child: Center(
            child: CircularProgressIndicator()
          )
        );
      }
    },
  );
  
  //filmsProvider.getNowPlaying();


 }
}