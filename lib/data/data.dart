import 'package:flutter/material.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final String path;
  ItemBoton(this.icon, this.texto, this.color1, this.color2, this.path);
}

final items = [
  ItemBoton(
    Icons.abc,
    'Abcdedario',
    Color(0xff6989F5),
    Color(0xff906EF5),
    '/abcdario',
  ),
  ItemBoton(
    Icons.numbers,
    'Números',
    Color(0xff66A9F2),
    Color(0xff536CF6),
    '/abcdario',
  ),
  ItemBoton(
    Icons.abc,
    'Traduccion',
    Color(0xffF2D572),
    Color(0xffE06AA3),
    '/translate',
  ),
];
