import 'package:flutter/material.dart';

final appTheme = ThemeData(
  cardTheme: const CardTheme(
    shape: LinearBorder(),
    elevation: 0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(36)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: const UnderlineInputBorder(borderRadius: BorderRadius.zero),
    filled: true,
    fillColor: Colors.grey.shade200,
  ),
  segmentedButtonTheme: const SegmentedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStatePropertyAll(LinearBorder()),
    ),
  ),
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.deepOrange,
    onPrimary: Colors.white,
    secondary: Colors.deepOrangeAccent,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Color(0xFFEEEEEE),
    onSurface: Color(0xFF444444),
    surfaceTint: Colors.transparent,
  ),
  useMaterial3: true,
);
