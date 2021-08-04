



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XOBox extends StatelessWidget {
  const XOBox({
    Key? key,
    this.xoValue = 0,
    required this.row,
    required this.col,
    required this.callback,
  }) : super(key: key);

  final int xoValue, row, col;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          callback(row, col);
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blueAccent),
              image: DecorationImage(
                image: (xoValue == 0 ? const AssetImage("assets/images/blank.jpg") :
                (xoValue == 1 ? const AssetImage("assets/images/letter_x.jpg") :
                const AssetImage("assets/images/letter_o.jpg"))),
                fit: BoxFit.fitHeight,
              )
          ),
        ),
      ),
    );
  }
}