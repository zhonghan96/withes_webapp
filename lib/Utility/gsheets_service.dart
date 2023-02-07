import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

import 'package:withes_webapp/Utility/config.dart';
import 'package:withes_webapp/auth/secrets.dart';

// Spreadsheet IDs
const spreadsheetId = '1lylaM1zQdOtgBCnXGSHP-9Esdxd7_tBVcL6t1uofIW8';
const orderSheetId = 0;
const menuSheetId = 1911157013;
var credentials = gsheetsCredentials;

class AvailableDates {
  final DateTime date;

  const AvailableDates({required this.date});

  @override
  String toString() {
    return "{date: $date}";
  }

  factory AvailableDates.fromGsheets(Map<String, dynamic> json) {
    return AvailableDates(
        date: DateTime(1899, 12, 29, 22, 55, 25)
            .add(Duration(days: int.parse(json['Date']))));
  }
}

class AvailableDatesManager {
  final gsheets = GSheets(credentials);
  Spreadsheet? spreadsheet;
  Worksheet? menuSheet;

  Future<void> init() async {
    spreadsheet ??= await gsheets.spreadsheet(spreadsheetId);
    menuSheet = spreadsheet!.worksheetById(menuSheetId);
  }

  Future<List<AvailableDates>> getAll() async {
    await init();
    final availableDates = await menuSheet!.values.map.allRows();
    return availableDates!
        .map((json) => AvailableDates.fromGsheets(json))
        .toList();
  }
}

class MenuItem {
  final DateTime date;
  final String mealType;
  final String cusine;
  final String foodDescription;

  const MenuItem({
    required this.date,
    required this.mealType,
    required this.cusine,
    required this.foodDescription,
  });

  @override
  String toString() {
    return "{date: $date, mealType: $mealType, cusine: $cusine, foodDescription: $foodDescription}";
  }

  factory MenuItem.fromGsheets(Map<String, dynamic> json) {
    return MenuItem(
        date:
            DateTime(1899, 12, 30).add(Duration(days: int.parse(json['Date']))),
        mealType: json['Meal Type'],
        cusine: json['Cusine'],
        foodDescription: json['Food Description']);
  }
}

class MenuItemManager {
  final gsheets = GSheets(credentials);
  Spreadsheet? spreadsheet;
  Worksheet? menuSheet;

  Future<void> init() async {
    spreadsheet ??= await gsheets.spreadsheet(spreadsheetId);
    menuSheet = spreadsheet!.worksheetById(menuSheetId);
  }

  Future<List<MenuItem>> getAll() async {
    await init();
    final menuItems = await menuSheet!.values.map.allRows();
    return menuItems!.map((json) => MenuItem.fromGsheets(json)).toList();
  }

  Future<List<dynamic>> filterMenu(List<dynamic> selectedDates) async {
    final fullMenu = await getAll();
    List filteredMenu = [];

    for (var i = 0; i < selectedDates.length; i++) {
      Map<String, dynamic> parsedMenu = {
        'date': selectedDates[i],
        'dinner': [],
        'breakfast': [],
        'lunch': [],
        'isExpanded': false
      };

      for (var j = 0; j < fullMenu.length; j++) {
        if (DateFormat('YYYYMMDD').format(selectedDates[i]) ==
            DateFormat('YYYYMMDD').format(fullMenu[j].date)) {
          switch (fullMenu[j].mealType) {
            case 'Dinner':
              {
                parsedMenu['dinner']!.add(fullMenu[j]);
              }
              break;
            case 'Lunch':
              {
                parsedMenu['lunch']!.add(fullMenu[j]);
              }
              break;
            case 'Breakfast':
              {
                parsedMenu['breakfast']!.add(fullMenu[j]);
              }
              break;
          }
        }
      }
      filteredMenu.add(parsedMenu);
    }
    return filteredMenu;
  }
}

class OrderDetails {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String addLine1;
  final String suburb;
  final String postcode;
  final String state;
  final String dietaryReq;
  final String meals;
  final num numofSets;
  final String selectedDates;
  final String selectedMeals;
  final String notes;

  const OrderDetails(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.addLine1,
      required this.suburb,
      required this.postcode,
      required this.state,
      required this.dietaryReq,
      required this.meals,
      required this.numofSets,
      required this.selectedDates,
      required this.selectedMeals,
      required this.notes});

  Map<String, dynamic> toGsheets() {
    return {
      'Order ID': id,
      'Name': name,
      'Email': email,
      'Phone': phone,
      'Address Line 1': addLine1,
      'Suburb': suburb,
      'Postcode': postcode,
      'State': state,
      'Dietary Requirements': dietaryReq,
      'Meals Wanted': meals,
      'Number of Sets': numofSets,
      'Selected Dates': selectedDates,
      'Selected Meals': selectedMeals,
      'Notes': notes
    };
  }
}

class OrderDetailsManager {
  final gsheets = GSheets(credentials);
  Spreadsheet? spreadsheet;
  Worksheet? ordersheet;

  Future<void> init() async {
    spreadsheet ??= await gsheets.spreadsheet(spreadsheetId);
    ordersheet = spreadsheet!.worksheetById(orderSheetId);
  }

  List compileSelectedDates() {
    var outputList = [];
    for (var i = 0; i < OrderData.selectedDates.length; i++) {
      outputList.add(DateFormat.MMMMd().format(OrderData.selectedDates[i]));
    }
    return outputList;
  }

  Future<bool> placeOrder() async {
    await init();
    OrderDetails orderDetails = OrderDetails(
        id: OrderData.id,
        name: OrderData.customerName,
        email: OrderData.customerEmail,
        phone: OrderData.customerPhone,
        addLine1: OrderData.addLine1,
        suburb: OrderData.addSuburb,
        postcode: OrderData.addPostcode,
        state: OrderData.addState,
        dietaryReq: OrderData.dietaryReq.join(', '),
        meals: OrderData.meals.join(', '),
        numofSets: OrderData.numOfSets,
        selectedDates: compileSelectedDates().join(', '),
        selectedMeals: OrderData.selectedMeals.toString(),
        notes: OrderData.customerNotes);
    ordersheet!.values.map
        .insertRowByKey(orderDetails.id, orderDetails.toGsheets());
    return true;
  }
}
