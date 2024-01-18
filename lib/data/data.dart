import 'package:flutter/material.dart';
import 'package:templat_project/custom_icons/custom_icons.dart';

class ItemBoton {
  final IconData icon;
  /* final String texto; */
  final Color color1;
  final Color color2;
  final String path;
  /* final String phase; */
  ItemBoton(
    this.icon,
    /* this.texto, */
    this.color1,
    this.color2,
    this.path,
    /* this.phase, */
  );
}

final items = [
  ItemBoton(
    CustomIcons.abcdario_icon,
    Color(0xff6989F5),
    Color(0xff906EF5),
    '/abcedario_page/Abcedario/abcdefghijklmnñopqrstuvwxyz',
  ),
  ItemBoton(
    CustomIcons.numbers_icon,
    Color(0xff66A9F2),
    Color(0xff536CF6),
    '/abcedario_page/Números/1234567890+-*=',
  ),
  ItemBoton(
    CustomIcons.translate_icon,
    Color(0xffF2D572),
    Color(0xffE06AA3),
    '/translate_page/Traductor/probandogente',
  ),
  ItemBoton(
    CustomIcons.braille_hand_icon_2,
    Color(0xff317183),
    Color(0xff46997D),
    '/phrase_maker_page/Creador%20frases/holaprobandogetexd',
  ),
];
