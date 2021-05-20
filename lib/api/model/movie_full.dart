import 'package:movie_search_app/api/utils.dart';

class MovieFull {
  final int kpId;
  final String title;
  final double rating;
  final String url;
  final String posterUrl;
  final int year;
  final String filmLength;
  final String slogan;
  final String description;
  final String type;
  final String ratingMPAA;
  final String ratingAgeLimits;
  final List<String> countries;
  final List<String> genres;

  MovieFull(this.kpId, this.title, this.rating, this.url, this.posterUrl, this.year, this.filmLength, this.slogan, this.description, this.type, this.ratingMPAA, this.ratingAgeLimits, this.countries, this.genres);

  static MovieFull fromJson(Map<String, dynamic> json) {
    return MovieFull(
        json['kp_id'],
        json['title'],
        json['rating'],
        json['url'],
        json['poster_url'],
        json['year'],
        json['film_length'],
        json['slogan'],
        json['description'],
        json['type'],
        json['rating_mpaa'],
        json['rating_age_limits'],
        parseListOfString(json['countries']),
        parseListOfString(json['genres'])
    );
  }
}