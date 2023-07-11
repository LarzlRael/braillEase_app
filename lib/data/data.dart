import 'package:flutter/material.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final String path;
  final String phase;
  ItemBoton(
    this.icon,
    this.texto,
    this.color1,
    this.color2,
    this.path,
    this.phase,
  );
}

final items = [
  ItemBoton(
    Icons.abc,
    'Abcdedario',
    Color(0xff6989F5),
    Color(0xff906EF5),
    '/abcdario',
    'abcdefghijklmnñopqrstuvwxyz',
  ),
  ItemBoton(
    Icons.numbers,
    'Números',
    Color(0xff66A9F2),
    Color(0xff536CF6),
    '/abcdario',
    '1234567890',
  ),
  ItemBoton(
    Icons.book,
    'Traductor',
    Color(0xffF2D572),
    Color(0xffE06AA3),
    '/translate',
    'Traductor',
  ),
  ItemBoton(
    Icons.book_online,
    'Creador de frases',
    Color(0xff317183),
    Color(0xff46997D),
    '/phrase_maker',
    'Traductor',
  ),
];
