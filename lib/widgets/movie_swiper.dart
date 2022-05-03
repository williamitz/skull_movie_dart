import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:skull_movie/models/models.dart';

class MovieSwiper extends StatelessWidget {
  final List<Movie> movies;

  const MovieSwiper({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final movieProvider = Provider.of<MovieProvider>(context, listen: true);

    final _size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
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
        itemCount: movies.length,
        layout: SwiperLayout.STACK,
        itemWidth: _size.width * 0.6,
        itemHeight: _size.height * 0.9,
        itemBuilder: (_, int i) {
          Movie movie = movies[i];

          // print('${movie.id}-swiper-$i');

          movie.heroId = '${movie.id}-swiper-$i';

          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'detail', arguments: movie),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: const AssetImage('assets/loading.gif'),
                    image: NetworkImage(movie.posterPath != null
                        ? movie.fullPoster
                        : 'https://i.stack.imgur.com/GNhxO.png')),
              ),
            ),
          );
        },
      ),
    );
  }
}
