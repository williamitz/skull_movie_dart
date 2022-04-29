import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skull_movie/providers/movie_provider.dart';
import 'package:skull_movie/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider(), lazy: false,)
      ],

      child: Scaffold(
    
        appBar: AppBar(
          title: const Text('Peliculas en cines') ,
          actions: [
            IconButton(
              icon: const Icon( Icons.search_outlined ),
              onPressed: () {}, 
            )
          ],
        ),
    
        body: SingleChildScrollView(
          child: Column(
            children:  const [
              
              SizedBox(height: 5.0),

              MovieSwiper(),
        
              MovieSlider(),
            ],
          ),
        ),
      ),
    );
  }
}