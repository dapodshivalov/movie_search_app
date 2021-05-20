import 'package:movie_search_app/api/utils.dart';

class Movie {
  final int kpId;
  final String title;
  final String posterUrl;
  final int year;
  final List<String> genres;

  Movie(this.kpId, this.title, this.posterUrl, this.year, this.genres);

  static Movie fromJson(Map<String, dynamic> json) {
    return Movie(
      int.tryParse(json['kp_id']),
      json['title'],
      json['poster_url'],
      int.tryParse(json['year'] == null ? "" : json['year']),
      parseListOfString(json['genres'])
    );
  }
}