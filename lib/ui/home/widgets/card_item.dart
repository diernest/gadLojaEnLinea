import 'package:flutter/material.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:gad_loja/model/provider/cart.dart';
import 'package:provider/provider.dart';

class CardItem extends StatelessWidget {
  final MyItem myItem;
  const CardItem({Key? key, required this.myItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double myCustomSize = (MediaQuery.of(context).size.width / 2) - 16;
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Colors.red, width: 2)),
      child: Container(
          height: myCustomSize,
          width: myCustomSize,
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
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.red,
                              ),
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: double.infinity,
                          height: 40,
                          child: Center(child: Consumer<CartModel>(
                              builder: (context, cart, child) {
                            return Text(
                              myItem.isAdd ? "REMOVER -" : "AGREGAR +",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            );
                          })),
                        ),
                      ),
                    )
                  : Container(),
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
          )),
    );
  }
}
