import 'package:gad_loja/repository/gad_repository.dart';
import 'package:gad_loja/ui/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final GadRepository _repository;

  HomeCubit(this._repository) : super(InitHomeState());

  Future<void> fetchHome() async {
    emit(LoadingHomeState());
    try {
      final response = await _repository.getAll();
      emit(ResponseHomeState(response));
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }
}
