import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skull_movie/providers/movie_provider.dart';
import 'package:skull_movie/screens/screens.dart';
import 'package:skull_movie/themes/ligth_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
          lazy: true,
        )

      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        
        initialRoute: '',
        routes: {
          '':(context) => const HomeScreen(),
          'detail':(context) => const DetiailScreen(),
        },
        theme: LigthTheme.theme,
      ),
    );
  }
}