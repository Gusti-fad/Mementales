import 'package:flutter/material.dart';

import './constants/colors.dart';

class AppTheme {

  static ThemeData lightTheme =
      ThemeData(

    useMaterial3: true,

    brightness:
        Brightness.dark,

    scaffoldBackgroundColor:
        const Color(0xFF090909),

    colorScheme:
        ColorScheme.fromSeed(

      brightness:
          Brightness.dark,

      seedColor:
          AppColors.primary,
    ),

    appBarTheme:
        const AppBarTheme(

      backgroundColor:
          Colors.transparent,

      elevation: 0,
    ),

    cardTheme:
        CardThemeData(

      elevation: 0,

      color:
          const Color(
        0xFF151515,
      ),

      shape:
          RoundedRectangleBorder(

        borderRadius:
            BorderRadius.circular(
          30,
        ),
      ),
    ),

    iconTheme:
        const IconThemeData(
      color:
          Colors.white,
    ),

    textTheme:
        const TextTheme(

      bodyLarge:
          TextStyle(
        color:
            Colors.white,
      ),

      bodyMedium:
          TextStyle(
        color:
            Colors.white,
      ),
    ),
  );
}