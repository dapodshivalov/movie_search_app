import 'package:movie_search_app/api/model/movie_full.dart';
import 'package:movie_search_app/api/model/person.dart';

abstract class MovieFullInfoState {
  static MovieFullInfoState result(MovieFull movie) {
    return Result(movie);
  }
  static MovieFullInfoState loading() {
    return Loading();
  }
  static MovieFullInfoState init() {
    return Init();
  }
  static MovieFullInfoState error() {
    return Error();
  }
}

class Init extends MovieFullInfoState {}

class Loading extends MovieFullInfoState {}

class Result extends MovieFullInfoState {
  MovieFull movie;

  Result(this.movie);
}

class ResultWithStaff extends Result {
  final List<Person> directors;
  final List<Person> actors;

  ResultWithStaff(MovieFull movie, this.directors, this.actors) : super(movie);
}

class Error extends MovieFullInfoState {}