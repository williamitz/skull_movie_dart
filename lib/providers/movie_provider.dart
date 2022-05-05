import 'dart:async';

import 'package:flutter/material.dart' show ChangeNotifier;
import 'package:http/http.dart' as http;
import 'package:skull_movie/helpers/debounder.dart';

import 'package:skull_movie/models/models.dart';

class MovieProvider extends ChangeNotifier {
  // static final MovieProvider _instance = MovieProvider._();
  // static MovieProvider get instance {
  //   return _instance;
  // }

  final String _urlBase = 'api.themoviedb.org';
  final String _apiKey = 'e2a6f8ea1a51a3a6bb20c35a6b9ce7ab';
  final String _language = 'es-ES';

  final debounder = Debouncer(duration: const Duration(milliseconds: 500));
  final _suggestionStreamCtrl = StreamController<List<Movie>>.broadcast();

  int _page = 1;
  int _popularPage = 1;

  int _movieId = 0;

  List<Cast> _credit = [];

  List<Movie> _nowMovies = [];
  List<Movie> _popularMovies = [];

  Stream<List<Movie>> get suggestionStream => _suggestionStreamCtrl.stream;

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

  List<Cast> get castMovie {
    return _credit;
  }

  int get counterNow {
    return _nowMovies.length;
  }

  int get counterPopular {
    return _popularMovies.length;
  }

  int get counterCast {
    return _credit.length;
  }

  Future<String> _resolveHttp(String endpoint, int page,
      [String query = '']) async {
    final url = Uri.https(_urlBase, endpoint, {
      'api_key': _apiKey,
      'page': '$_page',
      'language': _language,
      'query': query,
      'include_adult': 'true'
    });

    final response = await http.get(url);
    return response.body;
  }

  getNowMovies() async {
    final body = await _resolveHttp('3/movie/now_playing', _page);

    _page++;
    final movieResponse = MovieResponse.fromJson(body);
    _nowMovies = [...movieResponse.results];

    notifyListeners();
  }

  getPopularMovies() async {
    final body = await _resolveHttp('3/movie/popular', _popularPage);

    _popularPage++;
    final popularResponse = PopularResponse.fromJson(body);

    _popularMovies = [..._popularMovies, ...popularResponse.results];

    // if (response.statusCode == 200) {
    // } else {
    //   _popularMovies = [];
    // }

    notifyListeners();
  }

  Future<List<Cast>> getCreditMovie(int movieId) async {
    if (_movieId == movieId) return [..._credit];

    _movieId = movieId;

    final body = await _resolveHttp('3/movie/$_movieId/credits', 1);

    final creditResponse = CreditResponse.fromJson(body);

    _credit = [...creditResponse.cast];

    return creditResponse.cast;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final body = await _resolveHttp('3/search/movie', 1, query);

    final searchResponse = PopularResponse.fromJson(body);

    return searchResponse.results;
  }

  // Future<void> getSearchMovie(String query) async {
  //   final body = await _resolveHttp('3/search/movie', 1, query);

  //   final searchResponse = PopularResponse.fromJson(body);

  //   _suggestionStreamCtrl.sink.add(searchResponse.results);
  // }

  void getSuggestionByQuery(String query) {
    debounder.value = '';
    debounder.onValue = (val) async {
      print('buscando ============================ $val');
      final movies = await searchMovie(val);
      _suggestionStreamCtrl.add(movies);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 250), (_) {
      debounder.value = query;
    });

    Future.delayed(const Duration(milliseconds: 251))
        .then((_) => timer.cancel());
  }
}
