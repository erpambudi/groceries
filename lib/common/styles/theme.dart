import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyTheme {
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColor.primaryColor,
      splashColor: MyColor.secondaryColor,
      scaffoldBackgroundColor: MyColor.backgroundColor,
      backgroundColor: MyColor.backgroundColor,
      colorScheme: const ColorScheme.light(
        primary: MyColor.primaryColor,
        secondary: MyColor.secondaryColor,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: MyColor.primaryColor,
      ),
      textTheme: GoogleFonts.robotoTextTheme(ThemeData.light().textTheme),

      //Text Field Theme
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(
          color: MyColor.greyTextColor,
          fontSize: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color(0xFFE5E5E5),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            width: 1.5,
            color: MyColor.primaryColor,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      ),

      //Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: MyColor.primaryColor,
          onPrimary: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            vertical: 24,
            horizontal: 22,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(38),
          ),
        ),
      ),
    );
  }
}
