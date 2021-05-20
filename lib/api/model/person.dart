class Person {
  final int staffId;
  final String nameRu;
  final String nameEn;
  final String description;
  final String posterUrl;
  final String professionText;
  final String professionKey;

  Person(this.staffId, this.nameRu, this.nameEn, this.description, this.posterUrl, this.professionText, this.professionKey);

  static Person fromJson(Map<String, dynamic> json) {
    return Person(
        json['staffId'],
        json['nameRu'],
        json['nameEn'],
        json['description'],
        json['posterUrl'],
        json['professionText'],
        json['professionKey'],
    );
  }
}