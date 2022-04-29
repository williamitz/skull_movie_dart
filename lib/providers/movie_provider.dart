import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:http/http.dart' as http;

import 'package:skull_movie/models/models.dart';

class MovieProvider extends ChangeNotifier {
  // static final MovieProvider _instance = MovieProvider._();
  // static MovieProvider get instance {
  //   return _instance;
  // }

  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = 'e2a6f8ea1a51a3a6bb20c35a6b9ce7ab';
  final String _language = 'es-ES';
  int _page = 1;
  int _popularPage = 1;

  List<Movie> _nowMovies = [];
  List<Movie> _popularMovies = [];

  // factory() {
  //   return _instance;
  // }

  // MovieProvider._();

  MovieProvider() {
    getNowMovies();
    getPopularMovies();
  }

  List<Movie> get nowMovies {
    return _nowMovies;
  }

  List<Movie> get popularMovies {
    return _popularMovies;
  }

  int get counterNow {
    return _nowMovies.length;
  }

  int get counterPopular {
    return _popularMovies.length;
  }

  Future<String> _resolveHttp(String endpoint, int page) async {
    final url = Uri.https(_urlBase, endpoint,
        {'api_key': _apiKey, 'page': '$_page', 'language': _language});

    final response = await http.get(url);
    return response.body;
  }

  getNowMovies() async {
    // final url = Uri.https(_urlBase, '3/movie/now_playing',
    //     {'api_key': _apiKey, 'page': _page.toString(), 'language': _language});

    // final response = await http.get(url);

    final body = await _resolveHttp( '3/movie/now_playing', _page );

    _page++;
    final movieResponse = MovieResponse.fromJson(body);
    _nowMovies = [...movieResponse.results];

    notifyListeners();
  }

  getPopularMovies() async {
    // final url = Uri.https(_urlBase, '3/movie/popular',
    //     {'api_key': _apiKey, 'page': _page.toString(), 'language': _language});

    // final response = await http.get(url);

    final body = await _resolveHttp( '3/movie/popular', _popularPage );

    _popularPage++;
    final popularResponse = PopularResponse.fromJson(body);
    
    _popularMovies = [..._popularMovies, ...popularResponse.results];

    // if (response.statusCode == 200) {
    // } else {
    //   _popularMovies = [];
    // }

    notifyListeners();
  }
}
