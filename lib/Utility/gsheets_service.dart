import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

// Spreadsheet IDs
const spreadsheetId = '1lylaM1zQdOtgBCnXGSHP-9Esdxd7_tBVcL6t1uofIW8';
const orderSheetId = 0;
const menuSheetId = 1911157013;
const credentials = r'''
{
  "type": "service_account",
  "project_id": "convenience-delivered-app",
  "private_key_id": "cec90616a93668cc946fa2d377c9a6eeafd799b1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDwWmxXJDPXKWdl\nR7GFkGwL7yDvW0yiJSXSTVOI9h4P/S0eFt9Zq0iHFtgH0zGLLci/G+GyotvYVTzs\n8+TC5lpttZeYalnuKSBRq8+XBsqX1G7x+Z1xUbE+URndsHx3ICJd4HKVssFCv/Oh\niDIm64bjj21lKHMhWwwtM/FFrkFOjjp1XoXN5C+RxMOLTBZbFhDQxwMvACU/y4Cr\nWW3TOIUdYNq4dReWtpUT3FhtayJ6pB45KX9wRGMCTA9te11baxf+mIPHyWS9Qpiu\n9Sd5NjtUd91Xl3JQBM2ZRwiCBon8NEigemEen7hIMGvwM+c5D8Ld9h6vH8jX+Si/\njnhjcXIHAgMBAAECggEAAY98u5YbFg8JQlGUV/snkG5FhvhPR5A5LiPdYnrCmDT7\nGYJpgdIIXwQpc+eNn0s1TfRW40uGZOGsyxcMSa2oMaUnrlAmdFLlCFK2vtLG9vRk\nogKOYKF4pqBtLBDMxhM51eUyqUEnWxEW+loBhVorHogcXDdGhBVsv1BihSLL/sAP\nbU1IVHh2xoBnX5uoQqA0TteSLB9zoATTdfb6LEVfgfz2RC1hX+cV2LClzXbXULBQ\nfEAasTRZuWcbG7bL1yo+1e7mTiV0IrgKoSI97DDs3Q3LNK2avkvEsV/Bbqr7Fd/X\nge2rSnRTYVY/KMuVkSbqmjew6rfmToYLSspn1TsQiQKBgQD91dSaFrJcm85G6fjP\nJBzWZjQ9emDngu6dCCn7ZyKRPV81+6Av9RNYDofTovxWUuMi2GmX+riW5Sspo/C3\n8iqeUAyM1Gl9bNxt5vfNukA+1JtKUhdYD7r1CLrtNu41H+Wlg1WqKoKe7flrBPtR\nv4X+BoICxeFUzTmREfYwlnjcaQKBgQDyZyis/gMMcEow0NY3GdCoMElc5xXqunxW\nYHCkgp6owL00JW3+BdXtcCAuFidVnP8lwUJ+41IVD7GWLXjdYy8G9gA9UMZQf4WL\nPWNLpciHffZJ8EGUJOgV2MaVLCmgdEQt7mjelnzcMAX4xXi98ZOLAMpdPny1Xd18\nGhKkEjjM7wKBgEZu9AxBqgJKdWV1/MU1hw7y0yIP+B2lViKaplONHalhdy7agGtu\nPIzdk1DlU9F8NGxx0nMKbffo5R4r0FqqRqshGSpmslLMRynzweUC/lqw0dpAhxu3\nWbAuWPgDmvuAu08+7yFFpHMHI4NPoZDgbQS8t4yfbdQDEisv6bk3t5epAoGBAJ8t\nlsxi0WWtp0p/GOx+C0Mm0kYriXzmkRe3pMCi9cUjLBu+KIiTFHQjGT6qVZIm0nXc\nfuoMJK6n65oOqjvXEd6kVGvvSws5clyJJ1dZumEfGkhbePTrd2xBOcZjhcJUFyGC\nWWMxtzRwZLuEEVHJ/XVeQ4UPr5z50qPYCz2qqZoJAoGAM7Ko+rBri9KIYkWIxoyv\n7dhqJX2XGfjRuJ2+O+JHkM5BTNDgsk3A2MDBAT+MJeLzlGo4bZ5oDz19SJcB85sG\nQk5aeq6a4LshSCbkG1qu8Bhh57/zszAYxjvu0lTFa5FBSFvX1Z+cd+K5RVEBjelH\nV3BRV8u/F2KRAP1sYplR/mM=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@convenience-delivered-app.iam.gserviceaccount.com",
  "client_id": "101088941595068668652",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40convenience-delivered-app.iam.gserviceaccount.com"
}
''';

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
