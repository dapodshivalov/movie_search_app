List<String> parseListOfString(List<dynamic> data) {
  List<String> result = List.empty(growable: true);
  data.forEach((element) {
  result.add(element);
  });
  return result;
}