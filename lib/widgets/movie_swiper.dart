import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:skull_movie/providers/movie_provider.dart';

class MovieSwiper extends StatelessWidget {
  const MovieSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context, listen: true);

    final _size = MediaQuery.of(context).size;

    if (movieProvider.counterNow == 0) {
      return SizedBox(
        width: double.infinity,
        height: _size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: _size.height * 0.5,
      // color: Colors.purple,
      child: Swiper(
        itemCount: movieProvider.counterNow,
        layout: SwiperLayout.STACK,
        itemWidth: _size.width * 0.6,
        itemHeight: _size.height * 0.9,
        itemBuilder: (_, int i) {
          final movie = movieProvider.nowMovies[i];

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.posterPath != null
                      ? movie.fullPoster
                      : 'https://i.stack.imgur.com/GNhxO.png')),
            ),
          );
        },
      ),
    );
  }
}
