import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const color1 = Color.fromRGBO(50, 50, 66, 1);
const color2 = Color.fromRGBO(109, 109, 143, 1);
const color3 = Color.fromRGBO(168, 168, 220, 1);
const color4 = Color.fromRGBO(156, 223, 196, 1);
const color5 = Color.fromRGBO(254, 254, 254, 1);
const color6 = Color.fromRGBO(110, 120, 247, 1);
const color7 = Color.fromRGBO(75, 85, 170, 1);
const color8 = Colors.red;
final font = GoogleFonts.poppins();

ThemeData lighTheme = ThemeData(
  backgroundColor: color5,
    brightness: Brightness.light,
    primaryColor: color7,
    textTheme:  TextTheme(
        displayLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        titleMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        titleSmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelSmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        )),
       
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color7))),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: color7,
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: color1,
    primaryColor: color7,
    textTheme: TextTheme(
        displayLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        headlineSmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        titleMedium: GoogleFonts.poppins(
          color: color1,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        titleSmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: GoogleFonts.poppins(
          color: color1,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelSmall: GoogleFonts.poppins(
          color: color1,
          fontSize: 10,
          fontWeight: FontWeight.normal,
        )),
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: color7));
