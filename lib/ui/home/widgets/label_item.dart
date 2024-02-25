import 'package:flutter/material.dart';

class LabelItem extends StatelessWidget {
  final String text;
  final Color customColor;

  const LabelItem({super.key, required this.text, required this.customColor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: customColor,
            ),
            color: customColor,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        width: double.infinity,
        height: 40,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
