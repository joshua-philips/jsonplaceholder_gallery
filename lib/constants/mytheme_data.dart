import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.espresso,
  usedColors: 2,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  swapColors: true,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
    elevatedButtonRadius: 0.0,
    outlinedButtonRadius: 1.0,
    dialogRadius: 4.0,
    timePickerDialogRadius: 4.0,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.montserrat().fontFamily,
);

final ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.espresso,
  usedColors: 2,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 15,
  appBarOpacity: 0.90,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
    elevatedButtonRadius: 0.0,
    outlinedButtonRadius: 1.0,
    dialogRadius: 4.0,
    timePickerDialogRadius: 4.0,
  ),
  useMaterial3ErrorColors: true,
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.montserrat().fontFamily,
);
