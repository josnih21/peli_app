import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peli_app/src/models/film_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Film> films;
  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'), 
              image: NetworkImage(films[index].getPosterImg()),
              fit: BoxFit.cover
            )
          );
        },
        itemCount: films.length,
      ),
    );
  }
}
