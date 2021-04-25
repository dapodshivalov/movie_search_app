import 'package:movie_search_app/api/model/movie.dart';

abstract class SearchResultState {
  static SearchResultState result(List<Movie> movies) {
    return Result(movies);
  }
  static SearchResultState loading() {
    return Loading();
  }
  static SearchResultState init() {
    return Init();
  }
  static SearchResultState error() {
    return Error();
  }
}

class Init extends SearchResultState {}

class Loading extends SearchResultState {}

class Result extends SearchResultState {
  List<Movie> movies;

  Result(this.movies);
}

class Error extends SearchResultState {}