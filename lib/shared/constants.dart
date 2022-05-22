import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';

/// TODO: Edit textInputDecoration and buttonStyle according to Figma design

const textInputDecoration = InputDecoration(
    fillColor: Color.fromRGBO(242, 238, 238, 69),
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1.0,
            color: Color.fromRGBO(144, 132, 132, 53)) //color: Colors.white,)
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 3.0,
            color: Color.fromRGBO(89, 77, 77, 100)) // color: Colors.pink,)
    )
);

ButtonStyle buttonStyle = ButtonStyle(
  minimumSize: MaterialStateProperty.all(const Size(250.0, 36.0)),
  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
    borderRadius: BorderRadius.zero,
    side: BorderSide(color: Colors.grey))
  ),
);


ThemeData lightTheme = FlexThemeData.light(
  scheme: FlexScheme.green,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
);

ThemeData darkTheme = FlexThemeData.dark(
  scheme: FlexScheme.green,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 15,
  appBarStyle: FlexAppBarStyle.background,
  appBarOpacity: 0.90,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 30,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  useMaterial3: true,
  // To use the playground font, add GoogleFonts package and uncomment
  fontFamily: GoogleFonts.notoSans().fontFamily,
);