import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:withes_webapp/Utility/config.dart';
import 'package:withes_webapp/Utility/gsheets_integration.dart';

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
                    child: Text('Payment'),
                  )
                ],
              )
            ],
          )
        ]),
      );
    }

    return Column(
      children: [
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
    return filteredMenu =
        await MenuItemManager().filterMenu(OrderData.selectedDates);
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
          Text('Loading your menu . . .',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
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
      child: FutureBuilder(
        future: asyncInitState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return MenuList(menu: filteredMenu);
          } else {
            return progressIndicator();
          }
        },
      ),
    );
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
      appendList.add(rawList[i].cusine + ' - ' + rawList[i].foodDescription);
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
        'date': DateFormat.MMMMd().format(OrderData.selectedDates[i]),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 12, left: 10, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Please select your meals bellow ",
              style: appTheme.textTheme.headline5,
            ),
          ),
          SingleChildScrollView(
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
                        style: const TextStyle(fontSize: 20),
                      ));
                    },
                    body: Container(
                      color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: 100,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: const Text(
                                    'Dinner',
                                    style: TextStyle(fontSize: 18),
                                  )),
                              MealDropdown(
                                  foodDescriptionList:
                                      foodDescriptionParser(menu['dinner']),
                                  selectedDate:
                                      DateFormat.MMMMd().format(menu['date']),
                                  meal: 'dinner')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: 100,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: const Text(
                                    'Breakfast',
                                    style: TextStyle(fontSize: 18),
                                  )),
                              MealDropdown(
                                  foodDescriptionList:
                                      foodDescriptionParser(menu['breakfast']),
                                  selectedDate:
                                      DateFormat.MMMMd().format(menu['date']),
                                  meal: 'breakfast')
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  width: 100,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: const Text(
                                    'Lunch',
                                    style: TextStyle(fontSize: 18),
                                  )),
                              MealDropdown(
                                  foodDescriptionList:
                                      foodDescriptionParser(menu['lunch']),
                                  selectedDate:
                                      DateFormat.MMMMd().format(menu['date']),
                                  meal: 'lunch')
                            ],
                          ),
                        ],
                      ),
                    ),
                    isExpanded: menu['isExpanded']);
              }).toList(),
            ),
          ),
        ],
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
    if (OrderData.selectedMeals[i]['dinner'] != '') {
      priceOutput +=
          parseMealPricing('dinner', OrderData.selectedMeals[i]['dinner']);
    }
    if (OrderData.selectedMeals[i]['breakfast'] != '') {
      priceOutput += parseMealPricing(
          'breakfast', OrderData.selectedMeals[i]['breakfast']);
    }
    if (OrderData.selectedMeals[i]['lunch'] != '') {
      priceOutput +=
          parseMealPricing('lunch', OrderData.selectedMeals[i]['lunch']);
    }
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
            underline: const SizedBox(),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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

  try {
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
                          parseMealPricing('dinner', dinner)
                              .toStringAsFixed(2)),
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
  } catch (e) {
    for (var i = 0; i < OrderData.selectedDates.length; i++) {
      listTileList.add(Padding(
          padding: const EdgeInsets.only(left: 8),
          child: ListTile(
              title:
                  Text(DateFormat.MMMMd().format(OrderData.selectedDates[i])),
              subtitle: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(),
                    1: IntrinsicColumnWidth()
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: const [
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('Dinner: '),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('\$0.00'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('Breakfast: '),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('\$0.00'),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('Lunch: '),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: Text('\$0.00'),
                      ),
                    ]),
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
            Text('\$' + MenuPrice.singleSetTotal.toStringAsFixed(2) + ' AUD',
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text('\$' + MenuPrice.subtotal.toStringAsFixed(2) + ' AUD',
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
                  '\$' +
                      (MenuPrice.subtotal * MenuPrice.gst).toStringAsFixed(2) +
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('\$' + MenuPrice.finalTotal.toStringAsFixed(2) + ' AUD',
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
    for (var i = 0; i < OrderData.selectedMeals.length; i++) {
      if (OrderData.selectedMeals[i]['dinner'] == '' ||
          OrderData.selectedMeals[i]['breakfast'] == '' ||
          OrderData.selectedMeals[i]['lunch'] == '') {
        return 'Not all meals selected.\n If you don\'t need food for certain meals, please select "No food needed".';
      }
    }
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
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Order clear')));
        } else {
          _errorDialog(context, dataCheckResult);
        }
      },
    );
  }
}
