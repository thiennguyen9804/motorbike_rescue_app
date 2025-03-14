import 'package:flutter/material.dart';

class AppTheme {
  static final Color bgPos = const Color(0xff14AE5C);
  static final Color textPos = const Color(0xff14AE5C);
  // static final bigText = TextStyle(
  //   color: Color(0xff738F81),
  //   fontSize: 52,
  //   fontWeight: FontWeight.w800,
  //   shadows: <Shadow>[
  //     Shadow(
  //         offset: Offset(0, 4),
  //         blurRadius: 4.0,
  //         color: Color.fromARGB(25, 0, 0, 0)),
  //   ],
  // );
  // static final outlinedButtonTheme = OutlinedButtonThemeData(
  //   style: OutlinedButton.styleFrom(
  //     textStyle: const TextStyle(
  //       fontWeight: FontWeight.bold,
  //       fontSize: 17,
  //     ),
  //     foregroundColor: Color(0xff738F81),
  //     shape: RoundedRectangleBorder(
  //       side: BorderSide(
  //         color: Color(0xff949494), // your color here
  //         width: 1,
  //       ),
  //       borderRadius: BorderRadius.circular(100),
  //     ),
  //   ),
  // );
  static final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: bgPos,
      foregroundColor: Colors.white,
      // elevation: 0,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
    ),
  );

  static final inputDecorationTheme = InputDecorationTheme(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: bgPos),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: bgPos),
    ),
  );
  static final textSelectionTheme = TextSelectionThemeData(
    cursorColor: bgPos, // Change cursor color to green
    selectionHandleColor: bgPos, // Change selection handle color to green
  );

  static final fabTheme = FloatingActionButtonThemeData(
    backgroundColor: bgPos,
    foregroundColor: Colors.white,
  );

  static final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    elevatedButtonTheme: elevatedButtonTheme,
    inputDecorationTheme: inputDecorationTheme,
    textSelectionTheme: textSelectionTheme,
    floatingActionButtonTheme: fabTheme,
  );
}
