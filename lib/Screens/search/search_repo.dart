// ignore_for_file: constant_identifier_names

import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import 'search_model.dart';
import 'search_movie_list.dart';

const API_KEY = "c1b49f59";
const API_URL = "http://www.omdbapi.com/?apikey=";

Future<List<Movie>> searchMovies(keyword) async {
  final response = await http.get(Uri.parse('$API_URL$API_KEY&s=$keyword'));
  
  if (response.statusCode == 200) {
    var temp = json.decode(response.body);
    if (temp['Response'] == "True") {
      var data = temp['Search'];
      var list = (data as List).map((item) => Movie.fromJson(item)).toList();
      return list;
    } else {
      throw Exception(temp['Error']);
    }
  } else {
    throw Exception('Something went wrong !');
  }
}

Future<MovieInfo> getMovie(String movieId) async {
  final response = await http.get(Uri.parse('$API_URL$API_KEY&i=$movieId'));
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);

    if (data['Response'] == "True") {
      return MovieInfo.fromJSON(data);
    } else {
      throw Exception(data['Error']);
    }
  } else {
    throw Exception('Something went wrong !');
  }
}
