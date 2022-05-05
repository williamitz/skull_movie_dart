import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skull_movie/providers/movie_provider.dart';
import 'package:skull_movie/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final movieProvier = Provider.of<MovieProvider>(context);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            MovieSwiper(
              movies: movieProvier.nowMovies
            ),
            MovieSlider(
              movies: movieProvier.popularMovies, 
              onMoreMovies: () => movieProvier.getPopularMovies()
            ),
          ],
        ),
      ),
    );
  }
}
