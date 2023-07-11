import 'package:equatable/equatable.dart';
import 'package:gad_loja/model/my_item.dart';

abstract class CartState extends Equatable{}

class InitialCartState extends CartState{
  @override
  List<Object?> get props =>[];
}

class CurrentCartState extends CartState{
  final List<MyItem> items;
  CurrentCartState(this.items);
  @override
  List<Object?> get props =>[];
}

class LoadingCartState extends CartState{
  @override
  List<Object?> get props =>[];
}

