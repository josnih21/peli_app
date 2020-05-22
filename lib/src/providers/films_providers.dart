import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peli_app/src/models/actors_model.dart';

import 'package:peli_app/src/models/film_model.dart';

class FilmsProvider{
  //put your apiKey here
  String _apikey = '988f8c08a0c3483a4fe0ca8f4290858e';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;
  bool _charging = false;
  /*IMPORTANTE*/
  List<Film> _populars = new List();
  /*multiple listeners con broadcast*/
  final _popularsStreamController = StreamController<List<Film>>.broadcast();

  Function(List<Film>)get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Film>> get popularsStream => _popularsStreamController.stream;

  void dispose(){
    _popularsStreamController?.close();
  }

  Future<List<Film>> _processResponse(Uri url) async {
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    
    final films = new Films.fromJsonList(decodedData['results']);
    
    return films.items;
  }
  
  Future <List<Film>>getNowPlaying() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language' : _language  
    });

    return await _processResponse(url);
  }
  
  Future<List<Film>>getPopular() async{
      if(_charging) return [];
      _charging = true;
      _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language' : _language,
      'page' :  _popularsPage.toString()
    });

    final response = await _processResponse(url);
    _populars.addAll(response);
    popularsSink(_populars);
    _charging = false;
    return response;

  }

  Future<List<Actor>> getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits',{
      'api_key' : _apikey,
      'language' : _language
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final casting = new Actors.fromJsonList(decodedData['cast']);

    return casting.items;
  }
}