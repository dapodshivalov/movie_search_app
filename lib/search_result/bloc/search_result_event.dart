abstract class SearchResultEvent {}

class GetByQuery extends SearchResultEvent {
  final String query;

  GetByQuery(this.query);
}
