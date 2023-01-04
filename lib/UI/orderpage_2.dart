import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:withes_webapp/Utility/config.dart';
import 'package:withes_webapp/Utility/gsheets_integration.dart';

class OrderPage2 extends StatelessWidget {
  const OrderPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return MenuSelectionWidget();
  }
}

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
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 20),
        Text('Loading your menu . . .',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: asyncInitState(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return MenuList(menu: filteredMenu);
        } else {
          return progressIndicator();
        }
      },
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
    List<String> dropdownList = ['No meals needed'];
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
    for (var i = 0; i < OrderData.selectedDates.length; i++) {
      Map<String, String> orderInfo = {
        'date': DateFormat.MMMMd().format(OrderData.selectedDates[i]),
        'dinner': '',
        'breakfast': '',
        'lunch': ''
      };
      OrderData.selectedMeals.add(orderInfo);
    }
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
                  style: const TextStyle(fontSize: 20),
                ));
              },
              body: Container(
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DinnerDropdown(
                      foodDescriptionList:
                          foodDescriptionParser(menu['dinner']),
                      selectedDate: DateFormat.MMMMd().format(menu['date']),
                    ),
                    BreakfastDropdown(
                      foodDescriptionList:
                          foodDescriptionParser(menu['breakfast']),
                      selectedDate: DateFormat.MMMMd().format(menu['date']),
                    ),
                    LunchDropdown(
                      foodDescriptionList: foodDescriptionParser(menu['lunch']),
                      selectedDate: DateFormat.MMMMd().format(menu['date']),
                    ),
                  ],
                ),
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
  print(OrderData.selectedMeals);
}

class DinnerDropdown extends StatefulWidget {
  final List foodDescriptionList;
  final String selectedDate;
  const DinnerDropdown(
      {super.key,
      required this.foodDescriptionList,
      required this.selectedDate});

  @override
  State<DinnerDropdown> createState() => _DinnerDropdownState(
      foodDescriptionList: foodDescriptionList, selectedDate: selectedDate);
}

class _DinnerDropdownState extends State<DinnerDropdown> {
  final List _foodDescriptionList;
  final String _selectedDate;
  String? dropdownValue;

  _DinnerDropdownState(
      {required List foodDescriptionList, required selectedDate})
      : _foodDescriptionList = foodDescriptionList,
        _selectedDate = selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: 100,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: const Text(
              'Dinner',
              style: TextStyle(fontSize: 18),
            )),
        Expanded(
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
                    updateOrderInfo(_selectedDate, 'dinner', newValue!);
                    dropdownValue = newValue;
                  });
                },
                items: _foodDescriptionList.map((items) {
                  return DropdownMenuItem<String>(
                      value: items, child: Text(items));
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BreakfastDropdown extends StatefulWidget {
  final List foodDescriptionList;
  final String selectedDate;
  const BreakfastDropdown(
      {super.key,
      required this.foodDescriptionList,
      required this.selectedDate});

  @override
  State<BreakfastDropdown> createState() => _BreakfastDropdownState(
      foodDescriptionList: foodDescriptionList, selectedDate: selectedDate);
}

class _BreakfastDropdownState extends State<BreakfastDropdown> {
  final List _foodDescriptionList;
  final String _selectedDate;
  String? dropdownValue;

  _BreakfastDropdownState(
      {required List foodDescriptionList, required selectedDate})
      : _foodDescriptionList = foodDescriptionList,
        _selectedDate = selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: 100,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: const Text(
              'Breakfast',
              style: TextStyle(fontSize: 18),
            )),
        Expanded(
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
                    updateOrderInfo(_selectedDate, 'breakfast', newValue!);
                    dropdownValue = newValue;
                  });
                },
                items: _foodDescriptionList.map((items) {
                  return DropdownMenuItem<String>(
                      value: items, child: Text(items));
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LunchDropdown extends StatefulWidget {
  final List foodDescriptionList;
  final String selectedDate;
  const LunchDropdown(
      {super.key,
      required this.foodDescriptionList,
      required this.selectedDate});

  @override
  State<LunchDropdown> createState() => _LunchDropdownState(
      foodDescriptionList: foodDescriptionList, selectedDate: selectedDate);
}

class _LunchDropdownState extends State<LunchDropdown> {
  final List _foodDescriptionList;
  final String _selectedDate;
  String? dropdownValue;

  _LunchDropdownState(
      {required List foodDescriptionList, required selectedDate})
      : _foodDescriptionList = foodDescriptionList,
        _selectedDate = selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: 100,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: const Text(
              'Lunch',
              style: TextStyle(fontSize: 18),
            )),
        Expanded(
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
                    updateOrderInfo(_selectedDate, 'lunch', newValue!);
                    dropdownValue = newValue;
                  });
                },
                items: _foodDescriptionList.map((items) {
                  return DropdownMenuItem<String>(
                      value: items, child: Text(items));
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
