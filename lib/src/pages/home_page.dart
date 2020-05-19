import 'package:flutter/material.dart';

import 'package:peli_app/src/pages/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {

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
  return CardSwiper(
    films: [1,2,3,4,5]
  );
 }
}