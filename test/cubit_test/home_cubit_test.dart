import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gad_loja/model/info_home.dart';
import 'package:gad_loja/repository/gad_repository.dart';
import 'package:gad_loja/ui/home/cubit/home_cubic.dart';
import 'package:gad_loja/ui/home/cubit/home_state.dart';
import 'package:mockito/mockito.dart';

class MockGadRepository extends Mock implements GadRepository {}

class MockInfoHome extends Mock implements InfoHome {}

void main() {
  late GadRepository gadRepository;

  setUp(() => gadRepository = MockGadRepository());
  //user.when(callsTo("albums")).thenReturn(new Future(() => [album]));
  //when(client.fetchPost()).thenAnswer((_) async => Post(title: 'A'));
  //InfoHome.fromJson(<String, dynamic>{'key': 'value'})

  blocTest<HomeCubit, HomeState>(
      "Emite <ResponseHomeState> cuando respuesta valida ",
      setUp: () {
        when(
          () => gadRepository.getAll(),
        )
            /*.thenAnswer(
            (_) async => MockInfoHome()
        )*/;
      },
      build: () => HomeCubit(gadRepository),
      act: (bloc) => bloc.fetchHome(),
      expect: () => <HomeState>[ResponseHomeState(MockInfoHome())]);
}
