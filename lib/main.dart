import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:cloud_functions/cloud_functions.dart';

import 'package:withes_webapp/UI/orderpage_1.dart';

import 'package:withes_webapp/Utility/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print('Firebase Apps Length: ${Firebase.apps.length}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WithEs WebApp',
      theme: appTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            "CONVENIENCE DELIVERED",
            style: TextStyle(color: Color(0xFF012A51)),
          ),
        )),
        backgroundColor: const Color(0xFFFAFAFA),
        elevation: 0,
      ),
      body: const OrderPage1(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF037FF3),
        child: const Icon(Icons.help, color: Colors.white),
        onPressed: () {
          helpDialog(context);
          // callCloudFunction({
          //   'amount': MenuPrice.finalTotal,
          //   'orderId': OrderData.id,
          //   'receipt_email': OrderData.customerEmail,
          //   'card': {
          //     'number': '4242424242424242',
          //     'exp_month': 8,
          //     'exp_year': 2024,
          //     'cvc': '314',
          //   }            
          // });
        },
      ),
    );
  }
}

// callCloudFunction(input) async {
//   try {
//     final result = await FirebaseFunctions.instance
//         .httpsCallable('stripePayment')
//         .call(input);
//     print(result.data);
//   } on FirebaseFunctionsException catch (error) {
//     print("Error: ${error.message}");
//   }
// }
