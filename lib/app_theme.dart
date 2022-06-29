import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kOrangeColor = Color(0xffF94701);
const kBlackColor = Color(0xff0E0E0E);

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline1: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline1: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 11,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );
  static ThemeData light() {
    return ThemeData(
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      tabBarTheme: TabBarTheme(
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 14,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: kBlackColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: kOrangeColor,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: kOrangeColor,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
      textTheme: darkTextTheme,
      scaffoldBackgroundColor: kBlackColor,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: kOrangeColor,
        circularTrackColor: Colors.grey.shade600,
        refreshBackgroundColor: Colors.grey.shade600,
      ),
    );
  }
}
