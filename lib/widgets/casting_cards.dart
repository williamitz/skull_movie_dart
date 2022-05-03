import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skull_movie/models/models.dart';
import 'package:skull_movie/providers/movie_provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({Key? key, required this.movieId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movieProv = Provider.of<MovieProvider>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      height: 200,
      // color: Colors.black26,
      child: FutureBuilder(
        future: movieProv.getCreditMovie(movieId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {

            return Row(
              children: [
                Expanded(child: Container()),
                const CircularProgressIndicator(),
                Expanded(child: Container()),
              ],
            );

          }

          return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movieProv.counterCast,
              itemBuilder: (BuildContext context, int i) {
                final cast = movieProv.castMovie[i];

                return _CastingPoster(cast: cast);
              });
        },
      ),
    );
  }
}

class _CastingPoster extends StatelessWidget {
  final Cast cast;

  const _CastingPoster({
    Key? key,
    required this.cast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(cast.fullProfilePath),
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            cast.name,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
