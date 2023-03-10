import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'package:withes_webapp/UI/submitorderloading.dart';
import 'package:withes_webapp/Utility/config.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

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
                        Expanded(
                          child: Text(OrderData.address,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Text('Dietary Restrictions: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(OrderData.dietaryReq.join(', '),
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        const Text('Meals: ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        Text(OrderData.meals.join(', '),
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

parseMealPricing(selectedMealInfo) {
  double outputPrice = 0.00;
  int numOfMeals = 0;

  if (!selectedMealInfo['dinner'].isEmpty &&
      !selectedMealInfo['breakfast'].isEmpty &&
      !selectedMealInfo['lunch'].isEmpty) {
    if (selectedMealInfo['dinner'] != 'No food needed') {
      numOfMeals += 1;
    }
    if (selectedMealInfo['breakfast'] != 'No food needed') {
      numOfMeals += 1;
    }
    if (selectedMealInfo['lunch'] != 'No food needed') {
      numOfMeals += 1;
    }

    switch (numOfMeals) {
      case 1:
        {
          outputPrice = MenuPrice.setPrice['1'];
          break;
        }
      case 2:
        {
          outputPrice = MenuPrice.setPrice['2'];
          break;
        }
      case 3:
        {
          outputPrice = MenuPrice.setPrice['3'];
          break;
        }
    }
  }
  return outputPrice;
}

selectedMealsDisplay(List selectedMeals) {
  List<Widget> listTileList = [];

  if (selectedMeals.isEmpty) {
    for (var i = 0; i < OrderData.selectedDates.length; i++) {
      double mealPrice = 0.00;
      switch (OrderData.meals.length) {
        case 1:
          {
            mealPrice += MenuPrice.setPrice['1'];
            break;
          }
        case 2:
          {
            mealPrice += MenuPrice.setPrice['2'];
            break;
          }
        case 3:
          {
            mealPrice += MenuPrice.setPrice['3'];
            break;
          }
      }

      MenuPrice.singleSetTotal = mealPrice * OrderData.selectedDates.length;
      MenuPrice.deliveryFeesTotal =
          MenuPrice.deliveryFee * OrderData.selectedDates.length;
      MenuPrice.subtotal = (MenuPrice.singleSetTotal * OrderData.numOfSets) +
          MenuPrice.deliveryFeesTotal;
      MenuPrice.finalTotal = MenuPrice.subtotal * (1 + MenuPrice.gst);

      listTileList.add(Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(DateFormat.MMMMEEEEd().format(OrderData.selectedDates[i])),
              Text('\$${(mealPrice).toStringAsFixed(2)} AUD')
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 8, top: 5),
            child: Text(OrderData.meals.join(', ')),
          ),
        ),
      ));
    }
  } else {
    for (var i = 0; i < selectedMeals.length; i++) {
      var dinner = selectedMeals[i]['dinner'];
      var breakfast = selectedMeals[i]['breakfast'];
      var lunch = selectedMeals[i]['lunch'];

      listTileList.add(Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedMeals[i]['date']),
              Text(
                  '\$${(parseMealPricing(selectedMeals[i])).toStringAsFixed(2)} AUD')
            ],
          ),
          subtitle: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Dinner: $dinner'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Breakfast: $breakfast'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text('Lunch: $lunch'),
                  ),
                ],
              )),
        ),
      ));
    }
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
                    Text('\$${MenuPrice.singleSetTotal.toStringAsFixed(2)} AUD',
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
                          '\$${MenuPrice.deliveryFeesTotal.toStringAsFixed(2)} AUD',
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
                    Text('\$${MenuPrice.subtotal.toStringAsFixed(2)} AUD',
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
                          '\$${(MenuPrice.subtotal * MenuPrice.gst).toStringAsFixed(2)} AUD',
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
                    Text('\$${MenuPrice.finalTotal.toStringAsFixed(2)} AUD',
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
              padding: const EdgeInsets.only(top: 12, left: 20, bottom: 15),
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "Enter your credit card details here",
                  style: appTheme.textTheme.headlineSmall,
                ),
              ),
            ),
            const CreditCardField(),
            Container(
              padding: const EdgeInsets.only(top: 12, left: 20, bottom: 15),
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  "Any final notes for us about your order?",
                  style: appTheme.textTheme.headlineSmall,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter notes here'),
                onChanged: (text) {
                  OrderData.customerNotes = text;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)))),
              child: const Text(
                'Confirm Order',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SubmitOrderLoadingPage()));
              },
            )
          ],
        ));
  }
}

class CreditCardField extends StatefulWidget {
  const CreditCardField({super.key});

  @override
  State<CreditCardField> createState() => _CreditCardFieldState();
}

class _CreditCardFieldState extends State<CreditCardField> {
  OutlineInputBorder? border = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.7), width: 2));
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      OrderData.cardNumber = creditCardModel!.cardNumber;
      OrderData.expiryDate = creditCardModel.expiryDate;
      OrderData.cardHolderName = creditCardModel.cardHolderName;
      OrderData.cvvCode = creditCardModel.cvvCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CreditCardForm(
      formKey: formKey,
      cardNumber: OrderData.cardNumber,
      obscureNumber: true,
      cvvCode: OrderData.cvvCode,
      obscureCvv: true,
      expiryDate: OrderData.expiryDate,
      cardHolderName: OrderData.cardHolderName,
      onCreditCardModelChange: onCreditCardModelChange,
      themeColor: const Color(0xFF037FF3),
      cardNumberDecoration: InputDecoration(
        labelText: 'Number',
        hintText: 'XXXX XXXX XXXX XXXX',
        focusedBorder: border,
        enabledBorder: border,
      ),
      expiryDateDecoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        labelText: 'Expired Date',
        hintText: 'XX/XX',
      ),
      cvvCodeDecoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        labelText: 'CVV',
        hintText: 'XXX',
      ),
      cardHolderDecoration: InputDecoration(
        focusedBorder: border,
        enabledBorder: border,
        labelText: 'Card Holder',
      ),
    );
  }
}

//    _____             __ _
//   / ____|           / _(_)
//  | |     ___  _ __ | |_ _ _ __ _ __ ___
//  | |    / _ \| '_ \|  _| | '__| '_ ` _ \
//  | |___| (_) | | | | | | | |  | | | | | |
//   \_____\___/|_| |_|_| |_|_|  |_| |_| |_|

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({super.key});

  _orderDataCheck() {
    String errorMessage = '';

    if (OrderData.cardNumber.length < 19 ||
        OrderData.expiryDate.length < 5 ||
        OrderData.cvvCode.length < 3 ||
        OrderData.cardHolderName.isEmpty) {
      errorMessage += 'Please review your credit card information';
    }
    return errorMessage;
  }

  _errorDialog(BuildContext context, text) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              text,
              style: const TextStyle(height: 1.5),
            ),
            actions: [
              TextButton(
                  onPressed: Navigator.of(context).pop, child: const Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          elevation: 5,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)))),
      child: const Text(
        'Select your meals',
        style: TextStyle(fontSize: 16),
      ),
      onPressed: () {
        String dataCheckResult = _orderDataCheck();
        if (dataCheckResult.isEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SubmitOrderLoadingPage()));
        } else {
          _errorDialog(context, dataCheckResult);
        }
      },
    );
  }
}
