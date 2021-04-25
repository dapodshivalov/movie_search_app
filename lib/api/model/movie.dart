class Movie {
  final String title;
  final String posterUrl;
  final int releaseYear;
  final List<String> genres;

  Movie(this.title, this.posterUrl, this.releaseYear, this.genres);

  static Movie fromJson(Map<String, dynamic> json) {
    return Movie(
      json['title'],
      json['poster_url'],
      int.tryParse(json['release_year']),
      parseGenres(json['genres'])
    );
  }

  static List<String> parseGenres(List<dynamic> genres) {
    List<String> result = List.empty(growable: true);
    genres.forEach((element) {
      result.add(element);
    });
    return result;
  }
}