import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:gad_loja/ui/cart/cubit/cart_cubic.dart';
import 'package:gad_loja/ui/home/widgets/label_item.dart';

class CardItem extends StatelessWidget {
  final MyItem myItem;
  const CardItem({super.key, required this.myItem});

  @override
  Widget build(BuildContext context) {
    Color colorItem = myItem.value > 0 ? Colors.red : const Color(0XFFC89708);
    return BlocBuilder(
      bloc: BlocProvider.of<CartCubic>(context),
      builder: (context, snapshot) {
        return Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: colorItem, width: 1.5)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              myItem.value > 0
                  ? InkWell(
                      onTap: () {
                        var cart = context.read<CartCubic>();
                        if (myItem.isAdd) {
                          myItem.isAdd = false;
                          cart.remove(myItem);
                        } else {
                          myItem.isAdd = true;
                          cart.addToCart(myItem);
                        }
                      },
                      child: LabelItem(
                        customColor: myItem.isAdd
                            ? colorItem.withOpacity(0.7)
                            : colorItem,
                        text: myItem.isAdd ? "QUITAR -" : "AGREGAR +",
                      ))
                  : LabelItem(
                      customColor: colorItem,
                      text: "SIN DEUDAS",
                    ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/img/${myItem.icon}",
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    myItem.title,
                    style: const TextStyle(
                        color: Color(0xFF1A1A1A),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
