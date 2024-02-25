import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:gad_loja/ui/cart/cubit/cart_state.dart';

class CartCubic extends Cubit<CartState>{
  CartCubic() : super(InitialCartState());

  List<MyItem> listCart = [];

  final double iva = 0.0;
  final double comision = 0.50;

  int get getSubtotal =>
      listCart.fold(0, (total, current) => total + current.value);

  double get getTotal => getSubtotal + iva + comision;

  double get getIva => iva;

  double get getComision => comision;

  int get totalItems => listCart.length;

  bool existInCart(int id){
    bool response = false;
    for (var element in listCart) {
      if (element.id == id) {
        response = true;
      }
    }
    return response;
  }

  void addToCart(MyItem myItem) {
    emit(LoadingCartState());
    listCart.add(myItem);
    emit(CurrentCartState(listCart));
  }

  void remove(MyItem myItem) {
    emit(LoadingCartState());
    listCart.removeWhere((element) => element.id == myItem.id);
    if(listCart.isNotEmpty){
      emit(CurrentCartState(listCart));
    }else{
      emit(InitialCartState());
    }
  }


}