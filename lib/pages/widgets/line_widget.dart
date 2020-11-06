import 'package:flutter/material.dart';
import 'package:my_idena/utils/util_hexcolor.dart';

Widget lineWidget(double _width) {
  return Padding(
    padding: const EdgeInsets.only(top: 5),
    child: Container(
      height: 4,
      width: _width,
      decoration: BoxDecoration(
        color: HexColor('#000000').withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: _width,
            height: 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                HexColor('#000000').withOpacity(0.1),
                HexColor('#000000'),
              ]),
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
            ),
          )
        ],
      ),
    ),
  );
}
