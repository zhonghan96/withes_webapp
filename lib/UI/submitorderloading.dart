import 'package:flutter/material.dart';

import 'package:withes_webapp/UI/submitordersuccess.dart';
import 'package:withes_webapp/UI/submitorderfail.dart';
import 'package:withes_webapp/Utility/config.dart';
import 'package:withes_webapp/Utility/gsheets_service.dart';

class SubmitOrderLoadingPage extends StatelessWidget {
  const SubmitOrderLoadingPage({super.key});

  orderProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(children: [
        const SizedBox(
          height: 40,
          child: Center(
            child: LinearProgressIndicator(
              value: 0.75,
              color: Color(0xFF037FF3),
              backgroundColor: Colors.grey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Color(0xFF037FF3), shape: BoxShape.circle),
                  child: const Center(
                    child: Text('1',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('Details'),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Color(0xFF037FF3), shape: BoxShape.circle),
                  child: const Center(
                    child: Text('2',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('Meals'),
                )
              ],
            ),
            Column(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                      color: Color(0xFF037FF3), shape: BoxShape.circle),
                  child: const Center(
                    child: Text('3',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Text('Confirmation'),
                )
              ],
            )
          ],
        )
      ]),
    );
  }

  Future<void> executeAfterBuild(context) async {
    bool submitOrder = await OrderDetailsManager().placeOrder();
    Future.delayed(const Duration(seconds: 3), () {
      if (submitOrder) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OrderSuccessPage()));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const OrderFailPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    executeAfterBuild(context);
    final scrollController = ScrollController();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: confirmOrderWebappBar(context),
      body: Column(
        children: [
          const SizedBox(height: 10),
          orderProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SizedBox(
                height: screenSize.height - 170,
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Center(
                          child: Text('Processing your order . . .',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        )
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF037FF3),
        child: const Icon(Icons.help, color: Colors.white),
        onPressed: () {
          helpDialog(context);
        },
      ),
    );
  }
}
