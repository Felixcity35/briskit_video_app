class MovieInfo {
  final String title;
  final String year;
  final String rating;
  final String runtime;
  final String genre;
  final String director;
  final String plot;
  final String poster;
  final String imdbRating;
  final String metaScore;

  MovieInfo(
      {required this.title,
      required this.year,
      required this.rating,
      required this.runtime,
      required this.genre,
      required this.director,
      required this.plot,
      required this.poster,
      required this.imdbRating,
      required this.metaScore});

  factory MovieInfo.fromJSON(Map<String, dynamic> json) {
    return MovieInfo(
        title: json['Title'].toString(),
        year: json['Year'].toString(),
        rating: json['Ratings'][0]["Value"].toString(),
        runtime: json['Runtime'].toString(),
        genre: json['Genre'].toString(),
        director: json['Director'].toString(),
        plot: json['Plot'].toString(),
        poster: json['Poster'].toString(),
        imdbRating: json['imdbRating'].toString(),
        metaScore: json['Metascore'].toString());
  }
}
