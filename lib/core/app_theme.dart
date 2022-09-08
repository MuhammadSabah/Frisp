import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Text Theme for Light theme mode
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    bodyText2: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline1: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
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

  // Text Theme for Dark theme mode
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
      fontSize: 22,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    headline3: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w500,
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

  // Light ThemeData
  static ThemeData light() {
    return ThemeData(
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return kOrangeColor;
          }
          return Colors.white;
        }),
        trackColor: MaterialStateColor.resolveWith((states) => Colors.grey),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kOrangeColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        iconSize: 16,
        elevation: 4,
        backgroundColor: kOrangeColorTint2,
        foregroundColor: Colors.white,
      ),
      splashColor: Colors.white.withOpacity(0.5),
      // splashFactory: NoSplash.splashFactory,
      splashFactory: InkSplash.splashFactory,

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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
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
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
        unselectedItemColor: Colors.black,
        selectedItemColor: kOrangeColor,
      ),
      textTheme: lightTextTheme,
      scaffoldBackgroundColor: Colors.white,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: kOrangeColor,
        circularTrackColor: Colors.grey.shade300,
        refreshBackgroundColor: Colors.grey.shade300,
      ),
    );
  }

  // Dark ThemeData
  static ThemeData dark() {
    return ThemeData(
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return kOrangeColor;
          }
          return Colors.white;
        }),
        trackColor: MaterialStateColor.resolveWith((states) => Colors.grey),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: kOrangeColor,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        iconSize: 16,
        elevation: 4,
        backgroundColor: kOrangeColorTint2,
        foregroundColor: Colors.white,
      ),
      splashColor: Colors.white.withOpacity(0.5),
      splashFactory: InkSplash.splashFactory,
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
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: kBlackColor,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
        elevation: 0,
        backgroundColor: kBlackColor,
        iconTheme: IconThemeData(
          color: Colors.white,
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
        elevation: 0,
        backgroundColor: Colors.transparent,
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
