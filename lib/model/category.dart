/// Modelo de Categoría
class Category {
  late int id;
  late String name;
  late String description;
  late String imageUrl;
  late int prioridad;

  ///Código hexadecimal para pintar la categoría
  String? background;

  /// Icono que representa a la categoría
  String? icon;

  /// Orden en el cual se debe mostrar las categorías
  late int order;

  /// Type: Disposición del grid
  /// 0 vertical,ocupa dos espacios verticales del grid)
  /// 1 normal, ocupa un espacio del grid)
  /// 2 horizontal, ocupa dos espacio horizontales del grid)
  late int type;
  late bool status;
  List<Subcategory>? subcategorias = [];
  bool showInCategory = true;

  Category(this.id, this.name, this.description, this.imageUrl);

  Category.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'];
    this.name = parsedJson['name'] ?? "";
    this.description = parsedJson['description'] ?? "";
    this.imageUrl = parsedJson['image'] ?? '';
    this.prioridad = parsedJson['priority'] ?? 0;
    this.icon = parsedJson['icon'] ?? "";
    this.order = parsedJson['order'] ?? 0;
    this.status = parsedJson['status'] ?? false;
    if (this.order == 0) {
      this.order = 800; //Número exagerado, Para ubicarlo al final del array
    }
    this.background = parsedJson['background'];
    this.type = parsedJson['type'] ?? 1;
    bool _showInCategory = true;
    var _showInCategoryFromJson = parsedJson['showInCategory'] ?? true;
    if(_showInCategoryFromJson is int){
      _showInCategory = _showInCategoryFromJson==1?true:false;
    }else if(_showInCategoryFromJson is bool){
      _showInCategory = _showInCategoryFromJson;
    }
    this.showInCategory = _showInCategory;
    List<Subcategory> subcategorias = [];
    if (parsedJson['children'] != null) {
      for (int i = 0; i < parsedJson['children'].length; i++) {
        Subcategory result = Subcategory.fromJson(parsedJson['children'][i]);
        subcategorias.add(result);
      }
      this.subcategorias = subcategorias;
    } else {
      print(this.name);
    }
  }
}

class Subcategory {
  late int id;
  late String name;
  late bool activo;
  late bool status;
  late int order;
  bool showInCategory = true;

  Subcategory(
      {required this.id,
      required this.name,
      required this.status,
      required this.order});

  Subcategory.fromJson(Map<String, dynamic> parsedJson) {
    this.id = parsedJson['id'] ?? 0;
    this.name = parsedJson['name'] ?? "";
    this.status = parsedJson['status'] ?? false;
    this.order = parsedJson['order'] ??
        800; //Número exagerado, Para ubicarlo al final del array
    this.activo = false;
    bool _showInCategory = true;
    var _showInCategoryFromJson = parsedJson['showInCategory'] ?? true;
    if(_showInCategoryFromJson is int){
      _showInCategory = _showInCategoryFromJson==1?true:false;
    }else if(_showInCategoryFromJson is bool){
      _showInCategory = _showInCategoryFromJson;
    }
    this.showInCategory = _showInCategory;
  }
}
