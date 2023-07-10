import 'package:equatable/equatable.dart';
import 'package:gad_loja/model/info_home.dart';
import 'package:gad_loja/model/my_item.dart';

abstract class HomeState extends Equatable{}

class InitHomeState extends HomeState{
  @override
  List<Object> get props => [];
}

class LoadingHomeState extends HomeState{
  @override
  List<Object> get props => [];
}

class ErrorHomeState extends HomeState{
  final String msjError;
  ErrorHomeState(this.msjError);
  @override
  List<Object> get props => [];
}

class ResponseHomeState extends HomeState{
  final InfoHome infoHome;
  ResponseHomeState(this.infoHome);
  @override
  List<Object> get props => [];
}