import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';

class UIThemes {
  final Brightness brightness;

  UIThemes({this.brightness = Brightness.light});

  static ThemeData lightTheme() => ThemeData(
    brightness: Brightness.light,
    fontFamily: "MontrserratRegular",
    scaffoldBackgroundColor: LightModeColors.backgroundPrimary,
    dividerColor: LightModeColors.primaryColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: medium10Static.copyWith(color: LightModeColors.primaryColor),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      centerTitle: true,
      backgroundColor: LightModeColors.primaryColor,
      elevation: 0,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
    ),
    colorScheme: const ColorScheme.light(
      primary: LightModeColors.primaryColor,
      onSecondary: LightModeColors.whiteColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LightModeColors.greenAccent; // Цвет «кнопки» при ВКЛ
        }
        return LightModeColors.whiteColor;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return LightModeColors.whiteColor.withValues(alpha: 0.5);
        }
        return LightModeColors.whiteColor.withValues(alpha: 0.5);
      }),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      color: LightModeColors.primaryColor,
      surfaceTintColor: LightModeColors.primaryColor,
      height: 50,
      elevation: 0,
    ),
    textTheme: TextTheme(
      bodyMedium: medium10Static.copyWith(
        color: LightModeColors.textColorDefault,
      ),
    ),
  );

  static ThemeData darkTheme() => ThemeData(
    brightness: Brightness.dark,
    fontFamily: "MontrserratRegular",
    scaffoldBackgroundColor: DarkModeColors.backgroundPrimary,
    dividerColor: DarkModeColors.primaryColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      centerTitle: true,
      backgroundColor: DarkModeColors.backgroundPrimary,
      elevation: 0,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.1),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: medium10Static.copyWith(color: Colors.white),
    ),
    bottomAppBarTheme: const BottomAppBarThemeData(
      surfaceTintColor: DarkModeColors.backgroundPrimary,
      color: DarkModeColors.backgroundPrimary,
      height: 50,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.dark(
      primary: DarkModeColors.primaryColor,
      onSecondary: DarkModeColors.whiteColor,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return DarkModeColors.greenAccent; // Цвет «кнопки» при ВКЛ
        }
        return DarkModeColors.whiteColor;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return DarkModeColors.whiteColor.withValues(alpha: 0.5);
        }
        return DarkModeColors.whiteColor.withValues(alpha: 0.5);
      }),
    ),
    textTheme: TextTheme(
      bodyMedium: medium10Static.copyWith(color: DarkModeColors.whiteColor),
    ),
  );

  static UIThemes of(BuildContext context) {
    return UIThemes(brightness: Theme.of(context).brightness);
  }

  bool get isDarkTheme => brightness == Brightness.dark;

  Color get backgroundPrimary => isDarkTheme
      ? DarkModeColors.backgroundPrimary
      : LightModeColors.backgroundPrimary;

  Color get backgroundSecondary => isDarkTheme
      ? DarkModeColors.backgroundSecondary
      : LightModeColors.backgroundSecondary;

  Color get redColor =>
      isDarkTheme ? DarkModeColors.redColor : LightModeColors.redColor;

  Color get textColorDefault => isDarkTheme
      ? DarkModeColors.textColorDefault
      : LightModeColors.textColorDefault;

  Color get greenAccent =>
      isDarkTheme ? DarkModeColors.greenAccent : LightModeColors.greenAccent;

  Color get primaryColor =>
      isDarkTheme ? DarkModeColors.primaryColor : LightModeColors.primaryColor;
  Color get blackColor =>
      isDarkTheme ? DarkModeColors.blackColor : LightModeColors.blackColor;
  Color get whiteColor =>
      isDarkTheme ? DarkModeColors.whiteColor : LightModeColors.whiteColor;

  TextStyle get bold23 => TextStyle(
    fontSize: 23,
    fontFamily: 'MontrserratBold',
    color: textColorDefault,
  );

  TextStyle get bold20 => TextStyle(
    fontSize: 20,
    fontFamily: 'MontrserratBold',
    color: textColorDefault,
  );

  TextStyle get medium18 => TextStyle(
    fontSize: 18,
    fontFamily: 'MontrserratMedium',
    color: textColorDefault,
  );

  TextStyle get medium15 => TextStyle(
    fontSize: 15,
    fontFamily: 'MontrserratMedium',
    color: textColorDefault,
  );

  TextStyle medium10 = const TextStyle(
    fontSize: 10,
    fontFamily: 'MontrserratMedium',
    color: Colors.black,
  );

  static TextStyle medium10Static = const TextStyle(
    fontSize: 10,
    fontFamily: 'MontrserratMedium',
    color: Colors.black,
  );
}
