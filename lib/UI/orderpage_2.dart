import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:withes_webapp/UI/confirmationpage.dart';
import 'package:withes_webapp/Utility/config.dart';

class OrderPage2 extends StatelessWidget {
  const OrderPage2({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final screenSize = MediaQuery.of(context).size;

    buildWebView() {
      return Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                width: screenSize.width * 0.60,
                child: const MenuSelectionWidget()),
            const SizedBox(width: 20),
            SizedBox(
                width: screenSize.width * 0.30,
                child: const OrderSummaryWidget())
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
                width: screenSize.width * 0.8,
                child: const MenuSelectionWidget()),
            const SizedBox(height: 20),
            SizedBox(
                width: screenSize.width * 0.8,
                child: const OrderSummaryWidget())
          ],
        ),
      );
    }

    orderProgressIndicator() {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Stack(children: [
          const SizedBox(
            height: 40,
            child: Center(
              child: LinearProgressIndicator(
                value: 0.5,
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

    return Scaffold(
      appBar: webappBar(context),
      body: Column(
        children: [
          const SizedBox(height: 10),
          orderProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8),
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

//   _      _     _
//  | |    (_)   | |
//  | |     _ ___| |_ ___ _ __   ___ _ __
//  | |    | / __| __/ _ \ '_ \ / _ \ '__|
//  | |____| \__ \ ||  __/ | | |  __/ |
//  |______|_|___/\__\___|_| |_|\___|_|

class SelectedMealsNotifier {
  ValueNotifier _notifier = ValueNotifier(OrderData.selectedMeals);

  void updateNotifierValue() {
    _notifier.value = [OrderData.selectedMeals];
  }
}

SelectedMealsNotifier selectedMealNotifier = SelectedMealsNotifier();

class SubTotalNotifier {
  ValueNotifier _notifier = ValueNotifier(MenuPrice.subtotal);

  void updateNotifierValue() {
    _notifier.value = MenuPrice.subtotal;
  }
}

SubTotalNotifier subTotalNotifier = SubTotalNotifier();

//   __  __
//  |  \/  |
//  | \  / | ___ _ __  _   _
//  | |\/| |/ _ \ '_ \| | | |
//  | |  | |  __/ | | | |_| |
//  |_|  |_|\___|_| |_|\__,_|

class MenuSelectionWidget extends StatefulWidget {
  const MenuSelectionWidget({super.key});

  @override
  State<MenuSelectionWidget> createState() => _MenuSelectionWidgetState();
}

class _MenuSelectionWidgetState extends State<MenuSelectionWidget> {
  List<dynamic> filteredMenu = [];

  asyncInitState() async {
    return filteredMenu = await getFilteredMenu();
  }

  getFilteredMenu() async {
    List output = [];

    final db = FirebaseFirestore.instance;
    await db.collection('menu').get().then((snapshot) {
      for (var i in OrderData.selectedDates) {
        for (var j in snapshot.docs) {
          if (i == j.data()['date'].toDate()) {
            output.add({
              'date': j.data()['date'].toDate(),
              'dinner': j.data()['dinner'],
              'breakfast': j.data()['breakfast'],
              'lunch': j.data()['lunch'],
              'isExpanded': false
            });
          }
        }
      }
    });
    return output;
  }

  Widget progressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Center(
            child: Text('Loading your menu . . .',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, right: 8),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 12, left: 10, bottom: 10),
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text(
                      "Please select your meals bellow ",
                      style: appTheme.textTheme.headlineSmall,
                    ),
                    const Tooltip(
                      message: 'Help',
                      child: MealSelectHelp(),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: asyncInitState(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return MenuList(menu: filteredMenu);
                } else {
                  return progressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MealSelectHelp extends StatefulWidget {
  const MealSelectHelp({super.key});

  @override
  State<MealSelectHelp> createState() => _MealSelectHelpState();
}

class _MealSelectHelpState extends State<MealSelectHelp> {
  _helpDialog(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: Navigator.of(context).pop,
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      content: const Text(
        'Select your meals from the drop down of your selected dates\n\n'
        'If you are looking for more customization,\nplease send us a ticket from the Help Button at the lower right corner',
        style: TextStyle(height: 1.5),
      ),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.help),
        onPressed: () {
          setState(() {
            _helpDialog(context);
          });
        });
  }
}

class MenuList extends StatefulWidget {
  final List menu;
  const MenuList({super.key, required this.menu});

  @override
  State<MenuList> createState() => _MenuListState(menu: menu);
}

class _MenuListState extends State<MenuList> {
  final List _menu;
  _MenuListState({required List menu}) : _menu = menu;

  foodDescriptionParser(rawList) {
    List<String> dropdownList = ['No food needed'];
    List<String> appendList = [];

    for (var i = 0; i < rawList.length; i++) {
      appendList
          .add(rawList[i]['cusine'] + ' - ' + rawList[i]['foodDescription']);
    }

    appendList.sort();

    for (var j = 0; j < appendList.length; j++) {
      dropdownList.add(appendList[j]);
    }

    return dropdownList;
  }

  genOrderInfo() {
    List pendingOrderInfo = [];

    for (var i = 0; i < OrderData.selectedDates.length; i++) {
      Map<String, String> orderInfo = {
        'date': DateFormat.MMMMEEEEd().format(OrderData.selectedDates[i]),
        'dinner': '',
        'breakfast': '',
        'lunch': ''
      };
      pendingOrderInfo.add(orderInfo);
    }

    OrderData.selectedMeals = pendingOrderInfo;
  }

  @override
  void initState() {
    genOrderInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _menu[index]['isExpanded'] = !isExpanded;
          });
        },
        children: _menu.map<ExpansionPanel>((menu) {
          return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                    title: Text(
                  DateFormat.MMMMEEEEd().format(menu['date']),
                  style: const TextStyle(fontSize: 18),
                ));
              },
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 120,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              'Dinner',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                        MealDropdown(
                            foodDescriptionList:
                                foodDescriptionParser(menu['dinner']),
                            selectedDate:
                                DateFormat.MMMMEEEEd().format(menu['date']),
                            meal: 'dinner')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 120,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              'Breakfast',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                        MealDropdown(
                            foodDescriptionList:
                                foodDescriptionParser(menu['breakfast']),
                            selectedDate:
                                DateFormat.MMMMEEEEd().format(menu['date']),
                            meal: 'breakfast')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: 120,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: const Text(
                              'Lunch',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                        MealDropdown(
                            foodDescriptionList:
                                foodDescriptionParser(menu['lunch']),
                            selectedDate:
                                DateFormat.MMMMEEEEd().format(menu['date']),
                            meal: 'lunch')
                      ],
                    ),
                  ),
                ],
              ),
              isExpanded: menu['isExpanded']);
        }).toList(),
      ),
    );
  }
}

//   _____                  _____
//  |  __ \                |  __ \
//  | |  | |_ __ ___  _ __ | |  | | _____      ___ __
//  | |  | | '__/ _ \| '_ \| |  | |/ _ \ \ /\ / / '_ \
//  | |__| | | | (_) | |_) | |__| | (_) \ V  V /| | | |
//  |_____/|_|  \___/| .__/|_____/ \___/ \_/\_/ |_| |_|
//                   | |
//                   |_|

updateOrderInfo(String date, String meal, String mealDescription) {
  for (var i = 0; i < OrderData.selectedMeals.length; i++) {
    if (date == OrderData.selectedMeals[i]['date']) {
      OrderData.selectedMeals[i][meal] = mealDescription;
    }
  }

  selectedMealNotifier.updateNotifierValue();
}

updateSubtotal() {
  double priceOutput = 0.00;

  for (var i = 0; i < OrderData.selectedMeals.length; i++) {
    priceOutput += parseMealPricing(OrderData.selectedMeals[i]);
  }

  MenuPrice.singleSetTotal = priceOutput;
  MenuPrice.deliveryFeesTotal =
      MenuPrice.deliveryFee * OrderData.selectedDates.length;
  MenuPrice.subtotal =
      (priceOutput * OrderData.numOfSets) + MenuPrice.deliveryFeesTotal;
  subTotalNotifier.updateNotifierValue();
}

class MealDropdown extends StatefulWidget {
  final List foodDescriptionList;
  final String selectedDate;
  final String meal;

  const MealDropdown(
      {super.key,
      required this.foodDescriptionList,
      required this.selectedDate,
      required this.meal});

  @override
  State<MealDropdown> createState() => _MealDropdownState(
      foodDescriptionList: foodDescriptionList,
      selectedDate: selectedDate,
      meal: meal);
}

class _MealDropdownState extends State<MealDropdown> {
  final List _foodDescriptionList;
  final String _selectedDate;
  final String _meal;
  String? dropdownValue;

  _MealDropdownState(
      {required List foodDescriptionList, required selectedDate, required meal})
      : _foodDescriptionList = foodDescriptionList,
        _selectedDate = selectedDate,
        _meal = meal;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: DropdownButton<String>(
            value: dropdownValue,
            hint: const Text('Please select your meal of choice'),
            isExpanded: true,
            elevation: 16,
            underline: Container(height: 1, color: const Color(0xFF012A51)),
            onChanged: (String? newValue) {
              setState(() {
                updateOrderInfo(_selectedDate, _meal, newValue!);
                updateSubtotal();
                dropdownValue = newValue;
              });
            },
            items: _foodDescriptionList.map((items) {
              return DropdownMenuItem<String>(value: items, child: Text(items));
            }).toList(),
          ),
        ),
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

class OrderSummaryWidget extends StatefulWidget {
  const OrderSummaryWidget({super.key});

  @override
  State<OrderSummaryWidget> createState() => _OrderSummaryWidgetState();
}

class _OrderSummaryWidgetState extends State<OrderSummaryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, right: 8),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 8, left: 8, bottom: 8),
                child: Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: selectedMealNotifier._notifier,
                builder: (BuildContext context, value, Widget? child) {
                  return selectedMealsDisplay(value);
                }),
            ValueListenableBuilder(
                valueListenable: subTotalNotifier._notifier,
                builder: (BuildContext context, value, Widget? child) {
                  return pricingDisplay();
                }),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: ConfirmButton(),
            )
          ],
        ),
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

  try {
    for (var i = 0; i < selectedMeals[0].length; i++) {
      var dinner = selectedMeals[0][i]['dinner'];
      var breakfast = selectedMeals[0][i]['breakfast'];
      var lunch = selectedMeals[0][i]['lunch'];

      listTileList.add(Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(selectedMeals[0][i]['date']),
              Text(
                  '\$${(parseMealPricing(selectedMeals[0][i])).toStringAsFixed(2)} AUD')
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
  } catch (e) {
    for (var i = 0; i < OrderData.selectedDates.length; i++) {
      listTileList.add(Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(DateFormat.MMMMEEEEd()
                      .format(OrderData.selectedDates[i])),
                  const Text('\$0.00 AUD')
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text('Dinner:'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text('Breakfast:'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text('Lunch:'),
                    ),
                  ],
                ),
              ))));
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

pricingDisplay() {
  updateSubtotal();
  MenuPrice.finalTotal = MenuPrice.subtotal * (1 + MenuPrice.gst);

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Divider(
          thickness: 2,
          indent: 20,
          endIndent: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Cost of One Set: ', style: TextStyle(fontSize: 14)),
            Text('\$${MenuPrice.singleSetTotal.toStringAsFixed(2)} AUD',
                style: const TextStyle(fontSize: 14))
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Number of Sets:', style: TextStyle(fontSize: 14)),
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
              Text('\$${MenuPrice.deliveryFeesTotal.toStringAsFixed(2)} AUD',
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('\$${MenuPrice.subtotal.toStringAsFixed(2)} AUD',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('\$${MenuPrice.finalTotal.toStringAsFixed(2)} AUD',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
          ],
        )
      ],
    ),
  );
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

    for (var i = 0; i < OrderData.selectedMeals.length; i++) {
      if (OrderData.selectedMeals[i]['dinner'] == '' ||
          OrderData.selectedMeals[i]['breakfast'] == '' ||
          OrderData.selectedMeals[i]['lunch'] == '') {
        errorMessage =
            'Not all meals selected.\nIf you don\'t need food for certain meals, please select "No food needed".';
      }
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
        'Proceed to Payment',
        style: TextStyle(fontSize: 16),
      ),
      onPressed: () {
        String dataCheckResult = _orderDataCheck();
        if (dataCheckResult.isEmpty) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ConfirmationPage()));
        } else {
          _errorDialog(context, dataCheckResult);
        }
      },
    );
  }
}
