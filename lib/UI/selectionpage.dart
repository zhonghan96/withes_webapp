import 'package:flutter/material.dart';

import 'package:withes_webapp/UI/orderpage_2.dart';
import 'package:withes_webapp/UI/confirmationpage.dart';

import 'package:withes_webapp/Utility/config.dart';

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  orderProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(children: [
        const SizedBox(
          height: 40,
          child: Center(
            child: LinearProgressIndicator(
              value: 0.25,
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 4),
                      shape: BoxShape.circle),
                  child: const Center(
                    child: Text('2',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 4),
                      shape: BoxShape.circle),
                  child: const Center(
                    child: Text('3',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
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

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: webappBar(context),
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
                      padding: const EdgeInsets.only(top: 5, bottom: 15),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 20, right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 5,
                                offset: const Offset(4, 4))
                          ],
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, left: 20),
                                  child: Text(
                                    'How would you like to order your meals?',
                                    style: appTheme.textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ConfirmationPage()));
                                  },
                                  child: Container(
                                    width: screenSize.width * 0.45,
                                    height: screenSize.height * 0.5,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/es_select.jpg'),
                                            colorFilter: ColorFilter.mode(
                                                Colors.black54,
                                                BlendMode.darken),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 100),
                                        child: Text(
                                          'Let us select your\nmeals for you',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OrderPage2()));
                                  },
                                  child: Container(
                                    width: screenSize.width * 0.45,
                                    height: screenSize.height * 0.5,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/cus_select.jpg'),
                                            colorFilter: ColorFilter.mode(
                                                Colors.black54,
                                                BlendMode.darken),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25))),
                                    child: const FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 100),
                                        child: Text(
                                          'Select your meals\nyourself',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 60,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
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
