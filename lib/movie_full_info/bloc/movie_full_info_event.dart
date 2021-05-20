abstract class MovieFullInfoEvent {}

class GetByKpId extends MovieFullInfoEvent {
  final int kpId;

  GetByKpId(this.kpId);
}
