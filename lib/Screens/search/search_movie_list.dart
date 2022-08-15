class MovieListRepo {
  List<Movie> list;

  MovieListRepo({required this.list});

  factory MovieListRepo.fromJson(dynamic json) {
    var list1 = (json as List).map((item) => new Movie.fromJson(item)).toList();
    return MovieListRepo(list: list1);
  }
}

class Movie {
  String title;
  String year;
  String type;
  String poster;
  String imdbID;
  String rating;

  Movie(
      {required this.title,
      required this.year,
      required this.type,
      required this.poster,
      required this.imdbID,
      required this.rating});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['Title'].toString(),
        year: json['Year'].toString(),
        type: json['Type'].toString(),
        poster: json['Poster'].toString(),
        imdbID: json['imdbID'].toString(),
        rating: json['Rated'].toString());
  }
}
