import 'package:flutter/material.dart';

import 'package:withes_webapp/Utility/config.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

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
                  child: Text('Payment'),
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

    buildWebView() {
      return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                    width: screenSize.width * 0.45,
                    child: const CustomerInfo()),
                const SizedBox(height: 20),
                SizedBox(
                    width: screenSize.width * 0.45,
                    child: const OrderSummary()),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
                width: screenSize.width * 0.45, child: const PaymentWidget())
          ],
        ),
      );
    }

    buildMobileView() {
      return Container(
        width: screenSize.width * 0.95,
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                width: screenSize.width * 0.9, child: const CustomerInfo()),
            const SizedBox(height: 20),
            SizedBox(
                width: screenSize.width * 0.9, child: const OrderSummary()),
            const SizedBox(height: 20),
            SizedBox(
                width: screenSize.width * 0.9, child: const PaymentWidget()),
          ],
        ),
      );
    }

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
                  child: LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 1100) {
                      return buildWebView();
                    } else {
                      return buildMobileView();
                    }
                  }),
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

//    _____
//   / ____|
//  | (___  _   _ _ __ ___  _ __ ___   __ _ _ __ _   _
//   \___ \| | | | '_ ` _ \| '_ ` _ \ / _` | '__| | | |
//   ____) | |_| | | | | | | | | | | | (_| | |  | |_| |
//  |_____/ \__,_|_| |_| |_|_| |_| |_|\__,_|_|   \__, |
//                                                __/ |
//                                               |___/

class CustomerInfo extends StatelessWidget {
  const CustomerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          Container(
            padding: const EdgeInsets.only(top: 12, left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Customer Information",
              style: appTheme.textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          const Text('Name: ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text(OrderData.customerName,
                              style: const TextStyle(fontSize: 16)),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Text('Email: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(OrderData.customerEmail,
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Text('Phone Number: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(OrderData.customerPhone,
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Text('Address: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(
                            '${OrderData.addLine1}, ${OrderData.addSuburb}, ${OrderData.addPostcode}, ${OrderData.addState}',
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

parseMealPricing(String meal, String description) {
  switch (meal) {
    case 'dinner':
      {
        if (description.contains('Chinese')) {
          return MenuPrice.chinese['dinner'];
        } else if (description.contains('Indian')) {
          return MenuPrice.indian['dinner'];
        } else if (description.contains('Indonesian')) {
          return MenuPrice.indonesian['dinner'];
        } else {
          return 0.00;
        }
      }
    case 'breakfast':
      {
        if (description.contains('Chinese')) {
          return MenuPrice.chinese['breakfast'];
        } else if (description.contains('Indian')) {
          return MenuPrice.indian['breakfast'];
        } else if (description.contains('Indonesian')) {
          return MenuPrice.indonesian['breakfast'];
        } else {
          return 0.00;
        }
      }
    case 'lunch':
      {
        if (description.contains('Chinese')) {
          return MenuPrice.chinese['lunch'];
        } else if (description.contains('Indian')) {
          return MenuPrice.indian['lunch'];
        } else if (description.contains('Indonesian')) {
          return MenuPrice.indonesian['lunch'];
        } else {
          return 0.00;
        }
      }
  }
}

selectedMealsDisplay(List selectedMeals) {
  List<Widget> listTileList = [];

  for (var i = 0; i < selectedMeals.length; i++) {
    var dinner = selectedMeals[i]['dinner'];
    var breakfast = selectedMeals[i]['breakfast'];
    var lunch = selectedMeals[i]['lunch'];

    listTileList.add(Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        title: Text(selectedMeals[i]['date']),
        subtitle: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(),
                1: IntrinsicColumnWidth()
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Dinner: $dinner'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('\$' +
                        parseMealPricing('dinner', dinner).toStringAsFixed(2)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Breakfast: $breakfast'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('\$' +
                        parseMealPricing('breakfast', breakfast)
                            .toStringAsFixed(2)),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Lunch: $lunch'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('\$' +
                        parseMealPricing('lunch', lunch).toStringAsFixed(2)),
                  ),
                ]),
              ],
            )),
      ),
    ));
  }

  return ConstrainedBox(
    constraints: const BoxConstraints(minHeight: 150, maxHeight: 500),
    child: ListView(
      shrinkWrap: true,
      children: listTileList,
    ),
  );
}

class OrderSummary extends StatelessWidget {
  const OrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(4, 4))
          ],
        ),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.only(top: 12, left: 20, bottom: 8),
            alignment: Alignment.centerLeft,
            child: Text(
              "Order Summary",
              style: appTheme.textTheme.headlineSmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                selectedMealsDisplay(OrderData.selectedMeals),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Cost of One Set: ',
                        style: TextStyle(fontSize: 14)),
                    Text(
                        '\$' +
                            MenuPrice.singleSetTotal.toStringAsFixed(2) +
                            ' AUD',
                        style: const TextStyle(fontSize: 14))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Number of Sets:',
                          style: TextStyle(fontSize: 14)),
                      Text(OrderData.numOfSets.toString(),
                          style: const TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Delivery Fees:',
                          style: TextStyle(fontSize: 14)),
                      Text(
                          '\$' +
                              MenuPrice.deliveryFeesTotal.toStringAsFixed(2) +
                              ' AUD',
                          style: const TextStyle(fontSize: 14))
                    ],
                  ),
                ),
                const Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Subtotal: ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('\$' + MenuPrice.subtotal.toStringAsFixed(2) + ' AUD',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('GST: ', style: TextStyle(fontSize: 16)),
                      Text(
                          '\$' +
                              (MenuPrice.subtotal * MenuPrice.gst)
                                  .toStringAsFixed(2) +
                              ' AUD',
                          style: const TextStyle(fontSize: 16))
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                        '\$' + MenuPrice.finalTotal.toStringAsFixed(2) + ' AUD',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))
                  ],
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          )
        ]));
  }
}

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            Container(
                padding: const EdgeInsets.all(50),
                child: const Text('Payment Information goes here')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
              child: const Text(
                'Confirm Payment',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {},
            )
          ],
        ));
  }
}
