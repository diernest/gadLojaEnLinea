import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gad_loja/repository/gad_repository.dart';
import 'package:gad_loja/ui/cart/cubit/cart_cubic.dart';
import 'package:gad_loja/ui/home/cubit/home_cubic.dart';
import 'package:gad_loja/ui/navigation_bar.dart';


void main() {
  runApp(const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(create: (context) => HomeCubit(GadRepository())),
            BlocProvider<CartCubic>(create: (context) => CartCubic()),
          ],
          child: const MyNavigationBar(current: 0)),
    );
  }
}
