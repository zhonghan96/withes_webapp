import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
              color: Color(0xFF0a8ea0),
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
                      color: Color(0xFF0a8ea0), shape: BoxShape.circle),
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
                      color: Color(0xFF0a8ea0), shape: BoxShape.circle),
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
                      color: Color(0xFF0a8ea0), shape: BoxShape.circle),
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
            SizedBox(width: screenSize.width * 0.45, child: Container()),
            const SizedBox(
              width: 20,
            ),
            SizedBox(width: screenSize.width * 0.45, child: Container())
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
            SizedBox(width: screenSize.width * 0.9, child: Container()),
            const SizedBox(height: 20),
            SizedBox(width: screenSize.width * 0.9, child: Container())
          ],
        ),
      );
    }

    return Column(
      children: [
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
                    return CustomerInfo();
                  } else {
                    return CustomerInfo();
                  }
                }),
              ),
            ),
          ),
        ),
      ],
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
              style: appTheme.textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text('Name:', style: TextStyle(fontSize: 18))),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Email:', style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child:
                          Text('Phone Number:', style: TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text('Address:', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(OrderData.customerName,
                          style: const TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(OrderData.customerEmail,
                          style: const TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(OrderData.customerPhone,
                          style: const TextStyle(fontSize: 18)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(OrderData.address,
                          style: const TextStyle(fontSize: 18)),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            height: 200,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                  target: LatLng(OrderData.lat, OrderData.lang), zoom: 15),
              markers: <Marker>{
                Marker(
                    markerId: const MarkerId('1'),
                    position: LatLng(OrderData.lat, OrderData.lang))
              },
            ),
          )
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

  for (var i = 0; i < selectedMeals[0].length; i++) {
    var dinner = selectedMeals[0][i]['dinner'];
    var breakfast = selectedMeals[0][i]['breakfast'];
    var lunch = selectedMeals[0][i]['lunch'];

    listTileList.add(Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        title: Text(selectedMeals[0][i]['date']),
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
            padding: const EdgeInsets.only(top: 12, left: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Order Summary",
              style: appTheme.textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // selectedMealsDisplay(OrderData.selectedMeals),
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
                )
              ],
            ),
          )
        ]));
  }
}
