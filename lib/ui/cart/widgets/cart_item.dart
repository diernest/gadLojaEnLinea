import 'package:flutter/material.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:gad_loja/model/provider/cart.dart';
import 'package:gad_loja/ui/cart/widgets/cart_label.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final MyItem item;
  const CartItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          side: BorderSide(width: 1.0, color: Color(0XFFF1F1F1))),
      child: Container(
        height: 110,
        //color: Colors.teal,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CartLabel(title: "Servicio", subtitle: item.title),
                  CartLabel(title: "Código", subtitle: item.cod),
                  CartLabel(title: "Descripción", subtitle: item.description),
                  CartLabel(title: "\$${item.value}", subtitle: ""),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  var cart = context.read<CartModel>();
                  cart.remove(item);
                },
                child: Container(
                  color: Colors.transparent,
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
