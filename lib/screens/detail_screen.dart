import 'package:flutter/material.dart';
import 'package:skull_movie/models/models.dart';
import 'package:skull_movie/widgets/widgets.dart';

class DetiailScreen extends StatelessWidget {
  const DetiailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _DetailAppbar(
            title: movie.title,
            backdropPath: movie.fullBackdrop,
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            _PosterAndTitle(
              posterPath: movie.fullPoster,
              subtitle: movie.originalTitle,
              title: movie.title,
              voteaverage: movie.voteAverage,
              date: movie.releaseDate ?? '',
              heroId: movie.heroId!,
            ),
            _Overview(overview: movie.overview),
            CastingCards(movieId: movie.id,  )
          ]))
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String overview;

  const _Overview({
    Key? key,
    required this.overview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Text(
        overview,
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  final String posterPath;
  final String date;
  final double voteaverage;
  final String heroId;

  const _PosterAndTitle({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.posterPath,
    required this.voteaverage,
    required this.date, 
    required this.heroId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Hero(
              tag: heroId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(posterPath),
                  fit: BoxFit.cover,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: size.width - 150),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: _textTheme.headline5,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    subtitle,
                    style: _textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.star_outline),
                      const SizedBox(width: 10),
                      Text(
                        '$voteaverage',
                        style: _textTheme.caption,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_month_outlined),
                      const SizedBox(width: 10),
                      Text(date, style: _textTheme.caption)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class _DetailAppbar extends StatelessWidget {
  final String title;
  final String backdropPath;

  const _DetailAppbar({
    Key? key,
    required this.title,
    required this.backdropPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0.0),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 16.0),
          ),
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(color: Colors.black12),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(backdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
