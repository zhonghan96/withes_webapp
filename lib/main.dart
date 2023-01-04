import 'package:flutter/material.dart';

import 'package:withes_webapp/UI/orderpage_1.dart';
import 'package:withes_webapp/UI/orderpage_2.dart';
import 'package:withes_webapp/Utility/config.dart';

void main() {
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
        title: const Text("Convenience Delivered"),
        leading: Image.asset(esLogo),
        leadingWidth: 45,
        titleSpacing: 5,
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Redirect to FAQ or Help Ticket Submission'),
              ));
            },
          )
        ],
      ),
      body: const OrderPage2(),
    );
  }
}

