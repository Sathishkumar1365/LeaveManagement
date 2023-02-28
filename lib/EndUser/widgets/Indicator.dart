import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final bool? isActive;
  Indicator({Key? key, this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 350),
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: isActive!?22:8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive!?Colors.purple:Colors.grey,
        borderRadius: BorderRadius.circular(8)
      ),
    );
  }
}
