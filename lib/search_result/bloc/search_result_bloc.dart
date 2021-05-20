import 'package:bloc/bloc.dart';
import 'package:movie_search_app/api/model/movie.dart';
import 'package:movie_search_app/api/movie_repository.dart';
import 'package:movie_search_app/constant/preferences.dart';
import 'package:movie_search_app/search_result/bloc/search_result_event.dart';
import 'package:movie_search_app/search_result/bloc/search_result_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {

  MovieRepository movieRepository = MovieRepositoryImpl();

  SearchResultBloc() : super(SearchResultState.init());

  @override
  Stream<SearchResultState> mapEventToState(SearchResultEvent event) async* {

    if (event is GetByQuery) {
      yield SearchResultState.loading();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final shouldIncludeReviews = prefs.getBool(PR_KEY_SHOULD_INCLUDE_REVIEWS);
      List<Movie> movies = await movieRepository.getBy(query: event.query, shouldIncludeReviews: shouldIncludeReviews);
      yield SearchResultState.result(movies);
    }

  }

}