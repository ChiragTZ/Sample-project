import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iwl/theme/color.dart';
import 'package:iwl/utils/Constants.dart';

ThemeData themeData(BuildContext context) {
  return ThemeData(
    textSelectionTheme:
        const TextSelectionThemeData(cursorColor: colorSecondary),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: colorBackground,
      type: BottomNavigationBarType.fixed,
      elevation: 0.0,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),

    appBarTheme: const AppBarTheme(
      //backwardsCompatibility: false, // 1
      systemOverlayStyle: SystemUiOverlayStyle.light, // 2
      color: colorSecondary,
      elevation: 0.0,
      iconTheme: IconThemeData(color: colorWhite),
      titleTextStyle: TextStyle(
        color: colorWhite,
        letterSpacing: 1.2,
        wordSpacing: 1.2,
      ),
    ),
    primaryColor: colorPrimary,
    errorColor: colorError,
    brightness: Brightness.light,
    scaffoldBackgroundColor: colorBackground,
    backgroundColor: colorBackground,
    iconTheme: const IconThemeData(color: colorBlack),
//    accentIconTheme: IconThemeData(color: kAccentIconLightColor),
    primaryIconTheme: const IconThemeData(color: colorWhite),
    textTheme: TextTheme(
      headline1: GoogleFonts.inter(
        color: colorBlack,
        fontSize: 26,
      ),
      headline2: GoogleFonts.inter(
        color: colorBlack,
        fontSize: 24,
      ),
      headline3: GoogleFonts.inter(
        color: colorBlack,
        fontSize: 22,
      ),
      headline4: GoogleFonts.inter(
        color: colorBlack,
        fontSize: 20,
      ),
      caption: GoogleFonts.inter(
        color: colorBlack,
        fontSize: 38.0,
      ),
      // -------------------------------------------------
      headline5: TextStyle(
          color: colorBlack,
          fontFamily: SFProBold,
          fontSize: 22,
          letterSpacing: 0.35),
      headline6: TextStyle(
        color: colorBlack,
        fontFamily: SFProRegular,
        fontSize: 17,
      ),
      bodyText1: TextStyle(
        color: colorBlack,
        fontFamily: SFProRegular,
        fontSize: 17,
      ),
      bodyText2: TextStyle(
        color: colorBlack,
        fontFamily: SFProRegular,
        fontSize: 13,
      ),
      subtitle1: TextStyle(
        color: colorBlack,
        fontFamily: SFProSemiBold,
        fontSize: 17,
      ),
      subtitle2: TextStyle(
        color: colorBlack,
        fontFamily: SFProMedium,
        fontSize: 22,
      ),
      button: TextStyle(
        color: colorBlack,
        fontFamily: SFProRegular,
        fontSize: 17,
      ),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: colorSecondary),
  );
}
