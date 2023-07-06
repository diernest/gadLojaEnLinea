import 'package:flutter/material.dart';
class CartLabelDetails extends StatelessWidget {
  final String title;
  final String value;
  const CartLabelDetails({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4, horizontal: 18),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
          Text("\$$value",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16))
        ],
      ),
    );
  }
}
