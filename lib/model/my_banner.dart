/// Modelo de Banner
class MyBanner {
  late String url;
  late String description;

  MyBanner.fromJson(Map<String, dynamic> parsedJson) {
    url = parsedJson['url'];
    description = parsedJson['description'] ?? "";
  }
}
