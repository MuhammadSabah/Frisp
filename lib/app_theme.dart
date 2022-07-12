import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kOrangeColor = Color(0xffF94701);
const kOrangeColorTint = Color(0xfffa6c34);
const kOrangeColorTint2 = Color(0xfffb7e4d);
const kBlackColor = Color(0xff0E0E0E);
const kGreyColor = Color(0xff232220);

class AppTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline1: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 8,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );
  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline1: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    headline4: GoogleFonts.poppins(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 8,
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
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        elevation: 4,
        backgroundColor: kOrangeColorTint,
      ),
      splashColor: Colors.white.withOpacity(0.5),
      splashFactory: NoSplash.splashFactory,
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(Colors.white),
        fillColor: MaterialStateProperty.all(kOrangeColor),
        side: BorderSide(
          color: Colors.grey.shade800,
          width: 1.5,
        ),

        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(25),
        // ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 2,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: kOrangeColor,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelStyle: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.normal,
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
