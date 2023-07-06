import 'package:flutter/foundation.dart';
import 'package:gad_loja/model/my_item.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  final List<MyItem> items = [];

  final double iva = 0.0;
  final double comision = 0.50;

  /// List of items in the cart.
  List<MyItem> get myItems => items;

  /// The current total price of all items.
  int get getSubtotal =>
      items.fold(0, (total, current) => total + current.value);

  double get getTotal => getSubtotal + iva + comision;

  double get getIva => iva;

  double get getComision => comision;

  int get totalItems => items.length;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(MyItem item) {
    items.add(item);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(MyItem myItem) {
    items.removeWhere((element) => element.id == myItem.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}
