import 'package:bloc/bloc.dart';
import 'package:movie_search_app/api/model/person.dart';
import 'package:movie_search_app/api/movie_repository.dart';
import 'package:movie_search_app/movie_full_info/bloc/movie_full_info_event.dart';
import 'package:movie_search_app/movie_full_info/bloc/movie_full_info_state.dart';

class MovieFullInfoBloc extends Bloc<MovieFullInfoEvent, MovieFullInfoState> {
  final MovieRepository repository = MovieRepositoryImpl();

  MovieFullInfoBloc() : super(MovieFullInfoState.init());

  @override
  Stream<MovieFullInfoState> mapEventToState(MovieFullInfoEvent event) async* {
    if (event is GetByKpId) {
      yield Loading();

      final kpId = event.kpId;
      final movie = await repository.getByKpId(kpId);

      yield Result(movie);

      List<Person> persons = await repository.getStaffByKpId(kpId);

      List<Person> directors = List.empty(growable: true);
      List<Person> actors = List.empty(growable: true);

      persons.forEach((staff) {
        if (staff.professionKey == "DIRECTOR") {
          directors.add(staff);
        }
        if (staff.professionKey == "ACTOR") {
          actors.add(staff);
        }
      });

      yield ResultWithStaff(movie, directors, actors);
    }
  }

}