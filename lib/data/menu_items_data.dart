import 'package:flutter/material.dart';
import 'package:templat_project/custom_icons/custom_icons.dart';

class ItemBoton {
  final IconData icon;

  final Color color1;
  final Color color2;
  final String path;
  ItemBoton(
    this.icon,
    this.color1,
    this.color2,
    this.path,
  );
}

final items = [
  ItemBoton(
    CustomIcons.abcdario_icon,
    Color(0xff6989F5),
    Color(0xff906EF5),
    '/select_option_page/Abecedario/',
  ),
  ItemBoton(
    CustomIcons.translate_icon,
    Color(0xffF2D572),
    Color(0xffE06AA3),
    '/translate_page/Traductor/',
  ),
  ItemBoton(
    CustomIcons.braille_hand_icon_2,
    Color(0xff317183),
    Color(0xff46997D),
    '/phrase_maker_page/Creador%20frases/',
  ),
  /*  ItemBoton(
    Icons.gamepad,
    Color(0xff66A9F2),
    Color(0xff536CF6),
    '/games_selection_page/Juegos/',
  ) */
];
