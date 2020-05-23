import 'package:flutter/material.dart';
import 'package:peli_app/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Film> films;
  final Function nextPage;
  MovieHorizontal({@required this.films,@required this.nextPage});

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    _pageController.addListener((){
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
        nextPage();
      }
    });
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: films.length,
        itemBuilder: (context,i){
          return _crearTarjeta(context,films[i]);
        },
      ),
    );
  }

  Widget _crearTarjeta(BuildContext context,Film film){
    film.uniqueId = '${film.id}-poster';
    final tarjeta = Container(
        padding: EdgeInsets.only(top: 20.0),
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: film.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/loading.gif'), 
                  image: NetworkImage(film.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 140.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(film.title,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.caption,)
          ],
        ),
      );

      return GestureDetector(
        child: tarjeta,
        onTap: (){
          Navigator.pushNamed(context, 'detail',arguments: film);
        },
      );
  }

}