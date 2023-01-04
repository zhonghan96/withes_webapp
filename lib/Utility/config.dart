import 'package:flutter/material.dart';

//   _____ _       _           _
//   / ____| |     | |         | |
//  | |  __| | ___ | |__   __ _| |___
//  | | |_ | |/ _ \| '_ \ / _` | / __|
//  | |__| | | (_) | |_) | (_| | \__ \
//   \_____|_|\___/|_.__/ \__,_|_|___/

const kGoogleApiKey = 'AIzaSyCvJ2XC-qUS1s2vWvPplB3rKFQOZRY1MYI';
final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

const deliveryDates = [
  1,
  2,
  3,
  4
]; // Defines the days we deliver, with Sunday = 0 and Saturday = 6

class OrderData {
  static String customerName = '';
  static String customerEmail = '';
  static String customerPhone = '';
  static num numOfSets = 1;
  static String address = '';
  static String lat = '';
  static String lang = '';
  static List selectedDates = [
    DateTime.parse('2022-12-31'),
    DateTime.parse('2023-01-12')
  ];
  static List selectedMeals = []; // seperate dropdown to meal specific
}

// Pricing: Meal cost X, delivery cost Y

//                          _______ _
//      /\                 |__   __| |
//     /  \   _ __  _ __      | |  | |__   ___ _ __ ___   ___
//    / /\ \ | '_ \| '_ \     | |  | '_ \ / _ \ '_ ` _ \ / _ \
//   / ____ \| |_) | |_) |    | |  | | | |  __/ | | | | |  __/
//  /_/    \_\ .__/| .__/     |_|  |_| |_|\___|_| |_| |_|\___|
//           | |   | |
//           |_|   |_|

const primaryColor = Color(0xFF0a8ea0);
const primaryColorLight = Color(0xFF56bed1);
const primaryColorDark = Color(0xFF006071);
const primaryFontColor = Color(0xFFffffff);
const secondaryColor = Color(0xFFcaccd1);
const secondaryColorLight = Color(0xFFfdffff);
const secondaryColorDark = Color(0xFF999ba0);
const secondaryFontColor = Color(0xFF000000);

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Lato',
  textTheme: const TextTheme(
      headline5: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 20.0), //AppBar default textStyle
      subtitle1: TextStyle(fontSize: 16.0),
      subtitle2: TextStyle(fontSize: 14.0),
      bodyText1: TextStyle(fontSize: 16.0),
      bodyText2: TextStyle(fontSize: 14.0)),
  colorScheme: const ColorScheme.light().copyWith(
    primary: primaryColor,
    primaryContainer: primaryColorLight,
    secondary: secondaryColor,
    secondaryContainer: secondaryColorLight,
  ),
);

//   _____
//  |_   _|
//    | |  _ __ ___   __ _  __ _  ___  ___
//    | | | '_ ` _ \ / _` |/ _` |/ _ \/ __|
//   _| |_| | | | | | (_| | (_| |  __/\__ \
//  |_____|_| |_| |_|\__,_|\__, |\___||___/
//                          __/ |
//                         |___/

const esLogo = 'images/es_logo.png';

//  _____      _      _
//  |  __ \    (_)    (_)
//  | |__) | __ _  ___ _ _ __   __ _
//  |  ___/ '__| |/ __| | '_ \ / _` |
//  | |   | |  | | (__| | | | | (_| |
//  |_|   |_|  |_|\___|_|_| |_|\__, |
//                              __/ |
//                             |___/

//    _____      _            _       _   _
//   / ____|    | |          | |     | | (_)
//  | |     __ _| | ___ _   _| | __ _| |_ _  ___  _ __
//  | |    / _` | |/ __| | | | |/ _` | __| |/ _ \| '_ \
//  | |___| (_| | | (__| |_| | | (_| | |_| | (_) | | | |
//   \_____\__,_|_|\___|\__,_|_|\__,_|\__|_|\___/|_| |_|