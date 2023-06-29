import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorList = <Color>[
  Colors.purple,
  Colors.amber,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink,
  Colors.pinkAccent,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;
  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  })  : assert(selectedColor >= 0, 'Color index must be greater than 0'),
        assert(selectedColor < colorList.length,
            'Color index must be less than ${colorList.length}');
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        /* Text */
        textTheme: TextTheme(
          /*     titleLarge: GoogleFonts.montserratAlternates().copyWith(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: GoogleFonts.montserratAlternates().copyWith(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ), */
          titleSmall: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 20,
          ),
        ),
        colorSchemeSeed: colorList[0],
        /* appBarTheme: AppBarTheme(
          centerTitle: true,
          titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            /* color: Colors.black, */
          ),
        ), */
      );
  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
