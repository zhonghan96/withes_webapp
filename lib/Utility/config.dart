import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

//   _____ _       _           _
//   / ____| |     | |         | |
//  | |  __| | ___ | |__   __ _| |___
//  | | |_ | |/ _ \| '_ \ / _` | / __|
//  | |__| | | (_) | |_) | (_| | \__ \
//   \_____|_|\___/|_.__/ \__,_|_|___/

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
  static String addLine1 = '';
  static String addSuburb = '';
  static String addPostcode = '';
  static String addState = '';
  static String address = '';
  static List dietaryReq = [];
  static List meals = [];
  static num numOfSets = 1;
  static List selectedDates = [];
  static List selectedMeals = [];
  static String customerNotes = '';
}

class MenuPrice {
  // All prices are in AUD
  static double deliveryFee = 5.00;
  static Map chinese = {'dinner': 1.20, 'breakfast': 2.00, 'lunch': 3.00};
  static Map indian = {'dinner': 4.00, 'breakfast': 5.00, 'lunch': 6.00};
  static Map indonesian = {'dinner': 7.00, 'breakfast': 8.00, 'lunch': 9.00};
  static Map setPrice = {'1': 14.00, '2': 22.00, '3': 30.00};
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

const primaryColor = Color(0xFF037FF3);

ThemeData appTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ), //AppBar default textStyle
      titleMedium: TextStyle(fontSize: 16.0),
      titleSmall: TextStyle(fontSize: 14.0),
      bodyLarge: TextStyle(fontSize: 16.0),
      bodyMedium: TextStyle(fontSize: 14.0)),
  colorScheme: const ColorScheme.light().copyWith(
    primary: primaryColor,
  ),
);

webappBar(context) {
  return AppBar(
    title: const Center(
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text("CONVENIENCE DELIVERED",
            style: TextStyle(color: Color(0xFF012A51))),
      ),
    ),
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: Color(0xFF012A51)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    ),
    backgroundColor: const Color(0xFFFAFAFA),
    elevation: 0,
  );
}

helpDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Having trouble ordering?'),
          content: RichText(
            text: TextSpan(children: [
              const TextSpan(
                  text:
                      'Having issues with ordering online?\nLooking for something more tailored to what you are looking for?\n\nContact us at conveniencedelivered.es@gmail.com or send us your contact details ',
                  style: TextStyle(height: 1.5)),
              TextSpan(
                  text: 'here',
                  style: const TextStyle(height: 1.5, color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('tap');
                    })
            ]),
          ),
          actions: [
            TextButton(
                onPressed: Navigator.of(context).pop,
                child: const Text('Cancel'))
          ],
        );
      });
}

//   _____
//  |_   _|
//    | |  _ __ ___   __ _  __ _  ___  ___
//    | | | '_ ` _ \ / _` |/ _` |/ _ \/ __|
//   _| |_| | | | | | (_| | (_| |  __/\__ \
//  |_____|_| |_| |_|\__,_|\__, |\___||___/
//                          __/ |
//                         |___/

const esLogo = 'images/es_logo.png';
