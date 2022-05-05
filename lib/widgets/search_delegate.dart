import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skull_movie/models/models.dart';
import 'package:skull_movie/providers/movie_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '', 
        icon: const Icon(Icons.clear_outlined)
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          query = '';
          close(context, null);
          // Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          size: 200,
          color: Colors.black12,
        ),
      );
    }

    final movieProv = Provider.of<MovieProvider>(context);

    movieProv.getSuggestionByQuery( query );

    return StreamBuilder(
      stream: movieProv.suggestionStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<Movie> movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int i) {
            Movie movie = movies[i];
            movie.heroId = '${movie.id}-search-$i';
            return _MovieFinded(movie: movie);
          },
        );
      },
    );

  }
}

class _MovieFinded extends StatelessWidget {
  const _MovieFinded({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(1.0),
        width: 50,
        height: 150,
        child: Hero(
          tag: movie.heroId!,
          child: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.fullPoster),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () => Navigator.pushNamed(context, 'detail', arguments: movie),
    );
  }
}
