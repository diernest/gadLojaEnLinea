import 'package:flutter/material.dart';
import 'package:gad_loja/model/provider/cart.dart';
import 'package:gad_loja/ui/cart/widgets/cart_item.dart';
import 'package:gad_loja/ui/cart/widgets/cart_label.dart';
import 'package:gad_loja/ui/cart/widgets/cart_label_details.dart';
import 'package:provider/provider.dart';

import '../../model/my_item.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    List<MyItem> cartList =
        Provider.of<CartModel>(context, listen: true).myItems;

    return Scaffold(
        body: cartList.isNotEmpty
            ? CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                      child: Text(
                        "Servicios por pagar",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return CartItem(
                          item: cartList[index],
                        );
                      },
                      childCount: cartList.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Card(
                      child:
                          Consumer<CartModel>(builder: (context, cart, child) {
                        return Column(
                          children: [
                            CartLabelDetails(title: "Subtotal: ", value: "${cart.getSubtotal}"),
                            CartLabelDetails(title: "IVA: ", value: "${cart.getIva}"),
                            CartLabelDetails(title: "Comisiòn por transacción: ", value: "${cart.getComision}"),
                            CartLabelDetails(title: "Total: ", value: "${cart.getTotal}"),
                          ],
                        );
                      }),
                    ),
                  )
                ],
              )
            : const Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("¡Aún no has agregado un servicio!",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center),
                ),
              ));
  }
}
