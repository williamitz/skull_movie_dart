import 'package:flutter/material.dart';
import 'package:skull_movie/models/models.dart';

/// Nota: trabajar los scrollview con statefullwiget
class MovieSlider extends StatefulWidget {
  final List<Movie> movies;
  final Function onMoreMovies;

  const MovieSlider(
      {Key? key, required this.movies, required this.onMoreMovies})
      : super(key: key);

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  bool loading = false;

  final ScrollController scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollCtrl.addListener(() {
      double current = scrollCtrl.position.pixels;
      double last = scrollCtrl.position.maxScrollExtent - 250;

      if (current >= last && !loading) {
        setState(() {
          loading = true;
        });

        widget.onMoreMovies();

        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final movieProvider = Provider.of<MovieProvider>(context, listen: true);

    return SizedBox(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Populares',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Expanded(
            child: ListView.builder(
              controller: scrollCtrl,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies.length,
              itemBuilder: (_, int i) {
                Movie movie = widget.movies[i];
                movie.heroId = '${movie.id}-slider-$i';
                
                return _MoviePoster(
                  movie: movie,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: 130,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'detail', arguments: movie);
            },
            child: Hero(
              tag: movie.heroId! ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.fullPoster),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
