import 'package:badges/badges.dart' as MyBadge;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gad_loja/ui/cart/cubit/cart_cubic.dart';
import 'package:gad_loja/ui/cart/myCart.dart';
import 'package:gad_loja/ui/home/home.dart';

class MyNavigationBar extends StatefulWidget {
  final int current;

  const MyNavigationBar({super.key, required this.current});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
          height: 80,
          color: Colors.red,
          child: Center(
            child: Image.asset(
              "assets/img/logo_gad.png",
              width: 100,
              height: 40,
              fit: BoxFit.scaleDown,
            ),
          ),
        )),
        body: _getScaffoldBody(),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.red),
                label: "Home",
                backgroundColor: Colors.red),
            BottomNavigationBarItem(
                icon: MyBadge.Badge(
                    badgeStyle: MyBadge.BadgeStyle(
                        borderRadius: BorderRadius.circular(100),
                        shape: MyBadge.BadgeShape.circle,
                        badgeColor: Colors.black),
                    badgeContent: Center(
                        child: BlocBuilder(
                            bloc: BlocProvider.of<CartCubic>(context),
                            builder: (context, snapshot) {
                              return Text(
                                "${context.read<CartCubic>().totalItems}",
                                style: const TextStyle(color: Colors.white),
                              );
                            })),
                    child: const Icon(Icons.shopping_cart)),
                label: "Carrito"),
          ],
          onTap: ((value) {
            setState(() {
              currentIndex = value;
            });
          }),
        ),
      ),
    );
  }

  Widget _getScaffoldBody() {
    return callPage(currentIndex);
  }

  Widget callPage(int current) {
    switch (current) {
      case 0:
        return const Home();
      case 1:
        return const MyCart();
      default:
        return const Home();
    }
  }
}
