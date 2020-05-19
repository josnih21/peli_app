import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peli_app/src/models/film_model.dart';

class FilmsProvider{
  //put your apiKey here
  String _apikey = '';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future <List<Film>>getNowPlaying() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language' : _language  
    });

    final response = await http.get(url);
    final decodedData = json.decode(response.body);

    final films = new Films.fromJsonList(decodedData['results']);
    
    return films.items;
  }

}