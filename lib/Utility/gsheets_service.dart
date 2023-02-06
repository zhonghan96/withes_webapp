import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

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
