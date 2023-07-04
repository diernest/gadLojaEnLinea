import 'package:flutter/foundation.dart';
import 'package:gad_loja/model/my_item.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  final List<MyItem> items = [];

  /// List of items in the cart.
  List<MyItem> get myItems => items;

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.value);

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
