// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movies_app/Helpers/Constants/myColors.dart';

import 'search_item.dart';
import 'search_movie_list.dart';

class MovieList extends StatelessWidget {
  List<Movie> movies;

  MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: greyBG,
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        addAutomaticKeepAlives: true,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          return MovieItem(movie: movies[index]);
        },
      ),
    );
  }
}
