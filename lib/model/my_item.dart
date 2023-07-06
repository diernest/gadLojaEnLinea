/// Modelo de Item
class MyItem {
  late int id;
  late String icon;
  late String title;
  late String cod;
  late String description;
  late int value;
  late bool isAdd;

  MyItem.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    icon = parsedJson['icon'] ?? "";
    title = parsedJson['title'] ?? "";
    value = parsedJson['value'] ?? 0;
    cod = parsedJson['cod'] ?? "";
    description = parsedJson['description'] ?? "";
    isAdd = false;
  }

}
