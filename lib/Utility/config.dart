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

const stripePublishableKey =
    'pk_test_51MR8NcAMpCRAwrCpPOiVNy2yREgBu5BbrptNRu5lJmMW75hEoLVLGgQhidSqt4Yg91xSZUPNgxxsJUxELrIO7HDK00rOHFg8lU';
const stripeMerchantId = 'chua@withes.org';

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
  static String address = '';
  static double lat = 0;
  static double lang = 0;
  static num numOfSets = 2;
  static List selectedDates = [];
  static List selectedMeals = []; // seperate dropdown to meal specific
}

class MenuPrice {
  // All prices are in AUD
  static double deliveryFee = 5.00;
  static Map chinese = {'dinner': 1.20, 'breakfast': 2.00, 'lunch': 3.00};
  static Map indian = {'dinner': 4.00, 'breakfast': 5.00, 'lunch': 6.00};
  static Map indonesian = {'dinner': 7.00, 'breakfast': 8.00, 'lunch': 9.00};
  static double singleSetTotal = 0.00;
  static double deliveryFeesTotal = 0.00;
  static double subtotal = 0.00;
  static double gst = 0.1;
  static double finalTotal = 0.00;
}

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
      headline5: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
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

//    _____      _            _       _   _
//   / ____|    | |          | |     | | (_)
//  | |     __ _| | ___ _   _| | __ _| |_ _  ___  _ __
//  | |    / _` | |/ __| | | | |/ _` | __| |/ _ \| '_ \
//  | |___| (_| | | (__| |_| | | (_| | |_| | (_) | | | |
//   \_____\__,_|_|\___|\__,_|_|\__,_|\__|_|\___/|_| |_|
