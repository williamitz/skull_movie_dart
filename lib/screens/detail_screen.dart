import 'package:flutter/material.dart';
import 'package:skull_movie/widgets/widgets.dart';

class DetiailScreen extends StatelessWidget {
  const DetiailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: cambiar cuando tengamos la clase
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _DetailAppbar(title: movie),
          SliverList(
              delegate: SliverChildListDelegate([

                const _PosterAndTitle(),
                const _Overview(),

                const CastingCards()

              ])
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child:  Text(
        'Ex mollit aliquip ipsum veniam tempor fugiat exercitation officia consectetur magna ea incididunt. Minim do minim dolore duis reprehenderit ipsum proident. Pariatur ex anim consectetur aliqua. Pariatur laboris excepteur laborum reprehenderit eu consectetur aliquip qui eu fugiat. Duis enim cupidatat sint occaecat exercitation et excepteur magna enim occaecat deserunt. Fugiat sunt minim proident in reprehenderit. Adipisicing fugiat occaecat culpa commodo eu pariatur do laborum dolore cillum dolor veniam.',
        style: Theme.of(context).textTheme.subtitle1,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textTheme = Theme.of(context).textTheme;

    return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: const FadeInImage(
                placeholder: AssetImage('assets/loading.gif'),
                image: NetworkImage('https://via.placeholder.com/200x300'),
                fit: BoxFit.cover,
                height: 150,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              children: [
                Text(
                  'El señor de los anillos',
                  style: _textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'Título original',
                  style: _textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline),
                    const SizedBox(width: 10),
                    Text(
                      'movie.voteaverage',
                      style: _textTheme.caption,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    const SizedBox(width: 10),
                    Text('23 may', style: _textTheme.caption)
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}

class _DetailAppbar extends StatelessWidget {
  final String title;

  const _DetailAppbar({
    Key? key,
    required this.title,
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
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
