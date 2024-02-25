import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gad_loja/ui/cart/cubit/cart_cubic.dart';
import 'package:gad_loja/ui/cart/widgets/cart_item.dart';
import 'package:gad_loja/ui/cart/widgets/cart_label_details.dart';
import 'cubit/cart_state.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: BlocProvider.of<CartCubic>(context),
        builder: (context, snapshot) {
          if (snapshot is CurrentCartState) {
            var cart = context.read<CartCubic>();
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    child: Text(
                      "Servicios por pagar",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CartItem(
                        item: snapshot.items[index],
                      );
                    },
                    childCount: snapshot.items.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                      child: Column(
                    children: [
                      CartLabelDetails(
                          title: "Subtotal: ", value: "${cart.getSubtotal}"),
                      CartLabelDetails(title: "IVA: ", value: "${cart.getIva}"),
                      CartLabelDetails(
                          title: "Comisiòn por transacción: ",
                          value: "${cart.getComision}"),
                      CartLabelDetails(
                          title: "Total: ", value: "${cart.getTotal}"),
                    ],
                  )),
                ),
              ],
            );
          }
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("¡Aún no has agregado un servicio!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center),
            ),
          );
        });
  }
}
