import 'package:flutter/material.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:gad_loja/model/provider/cart.dart';
import 'package:gad_loja/ui/home/widgets/label_item.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final MyItem myItem;
  const CardItem({Key? key, required this.myItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorItem = myItem.value > 0 ? Colors.red : Color(0XFFC89708);
    return Card(
      margin: EdgeInsets.all(8.0),
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
                    var cart = context.read<CartModel>();
                    if (myItem.isAdd) {
                      myItem.isAdd = false;
                      cart.remove(myItem);
                    } else {
                      myItem.isAdd = true;
                      cart.add(myItem);
                    }
                  },
                  child:  Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return LabelItem(
                          customColor:  myItem.isAdd ? colorItem.withOpacity(0.7) : colorItem,
                          text: myItem.isAdd ? "QUITAR -" : "AGREGAR +",
                        );
                      })
                )
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
  }
}
