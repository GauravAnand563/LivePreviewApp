import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme() {
    themeMode =
        (themeMode == ThemeMode.dark) ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class MyThemes {
  static final lightTheme = ThemeData(
      colorScheme: ColorScheme.light(
          secondary: Color.fromARGB(255, 233, 245, 253),
          primary: Colors.white,
          tertiary: Colors.transparent),
      primaryColor: Colors.white,
      backgroundColor: Color(0xff148DE5),
      textTheme: TextTheme(
          headline1: GoogleFonts.sourceSansPro(
              color: Colors.black,
              textStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 0.7)),
          headline6: GoogleFonts.roboto(
              color: Colors.black,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          subtitle1: GoogleFonts.poppins(
              color: Colors.grey,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          bodyText1: GoogleFonts.sourceSansPro(
              color: Colors.black,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          headline5: GoogleFonts.sourceSansPro(
              color: Colors.black,
              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
          overline: GoogleFonts.notoSans(
              color: Colors.blueGrey,
              textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400))),
      iconTheme: IconThemeData(color: Colors.white, size: 20));

  //Dark Theme
  static final darkTheme = ThemeData(
      colorScheme: ColorScheme.dark(
        primary: Color(0xff0E1219),
        secondary: Color.fromARGB(255, 35, 39, 45),
        tertiary: Color.fromARGB(255, 55, 47, 56),
      ),
      primaryColor: Color(0xff0E1219),
      backgroundColor: Colors.white,
      textTheme: TextTheme(
          headline1: GoogleFonts.sourceSansPro(
              color: Colors.white,
              textStyle: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w200,
                  letterSpacing: 0.7)),
          headline6: GoogleFonts.roboto(
              color: Colors.white,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          subtitle1: GoogleFonts.poppins(
              color: Colors.white,
              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          bodyText1: GoogleFonts.sourceSansPro(
              color: Colors.white,
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
          headline5: GoogleFonts.sourceSansPro(
              color: Colors.white,
              textStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w300)),
          overline: GoogleFonts.notoSans(
              color: Colors.white,
              textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400))),
      iconTheme: IconThemeData(color: Colors.white70, size: 20));
}
