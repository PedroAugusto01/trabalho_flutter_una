import 'package:flutter/material.dart';

Widget mainLogo() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            child: new RawMaterialButton(
              onPressed: () {},
              child: Image.network("https://logospng.org/download/hotmart/logo-hotmart-icone-512.png"),
              shape: new CircleBorder(),
              elevation: 2.0,
              fillColor: Colors.white,
              padding: const EdgeInsets.all(38.0),
            ),
          ),
        ),
      ],
    ),
  );
}