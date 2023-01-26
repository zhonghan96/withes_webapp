import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

// Spreadsheet IDs
const spreadsheetId = '1lylaM1zQdOtgBCnXGSHP-9Esdxd7_tBVcL6t1uofIW8';
const orderSheetId = 0;
const menuSheetId = 1911157013;
const credentials = r'''
{
  "type": "service_account",
  "project_id": "fleet-goal-372106",
  "private_key_id": "d6fb445b09723dd59c721636ca65ef60554a1ea5",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC66diGSrHlEexF\nYsIyBM4aBFzcLNh/5OwoMo3gV8L/VeAzAcf0LVSZFokVGJjsmpX/sHahtbZ5yK3G\n8Z6Dc8O/TUBUIzdcgt/cLyCJwDqDDJjXIZGgRXLkdPt3xMrrBuc3NkSfvhPF9vOm\n8340kG4vRZiKN6rMVCFrottt2244osrLQmSlINy3Xfn9pZdSL2q8eRqnMoCuHnRd\nR0k+mat3zUpeWfS3GyeofYUa+CrTAjzFrBrtiO5uakWzYWWUEnG2h9JZFYCAIHYX\nU16L+GRhtXnLxgqV5l1jDXUjAWAeoAueVoRjCB/KAzBuv3PMfD9RRvN6JXYI3Hpk\nxKSzt2JBAgMBAAECggEAMYnPzsvWOUGWTs99a5dVbpTQbbRfDwqDwqWfb6Gi91xx\nxuMGdUNcZBSScWprAW55KeLBlltcSQu0bwFTw0A31ahqT8JjpluzbB57b7boaxo4\nGfB2MbWmXUFZ8qTQKRlTx5DVAEd24yVv70Qio1jSMyotYxic5nm3v9jSclvRayXZ\n0Kls/1XzO1tp6/wXT1qixlFc6wCNvPRqGfh7DMuzkyk3pOgoz4KZFUNyGsykcolY\npW7D2aLYYXYjTLfqYSEUt2f4Az2LDkfZR09oaUKautT6ZyhR1ZuRLHRWqjnRJ/kR\nOVFShqS24Pet8Rtzbv8A4LaaI4FrBBZOmyQ7cmxAhwKBgQDvWNjI2EN8or4lN8Ff\nWymKprgUHKlggJvuCK3IefpvY90E2wfks6ksKvziK5DNQVxiqcGK1/lUdAFRp1a/\nYtdYKEb1LnuuTwCbWuo5ZplGEA56iaM1JQxw+zD3dTe78+MIhA7JCGF7ZRiTmhmK\nN40r1YOqvu5uVm92WarJDeA6twKBgQDH6xKp+Y12WItif+1/3/F7lX9rzcmpdY6B\nm8VA/ZcDNEF3+6nCutC8FHnFMO9NXmP1/1ycxKTROIhKdBeSyddM7UUFeRrDfivW\nAKlwPlDykZeXiMgcdZGr2dGrzzFUBa64YzwoNofgEU/Dnjw2/xTSvdIsEhy4uIP0\nEU7sLp4yxwKBgQCw5mPjniPTHJ2Y+GqNxd0gQzTOeJifYK7e8b8v6yez6IVUr2ZY\nHImuwV8C8twlOGfF7F3F9vaq+sp2xU2SSsWKvMolMOPs4ys5p6pyHmiupfNtkgj0\noJtfbei1HQfCfPGSO7iJ0Q3rm77caQrzYzeN7FNSgafMGUpsmL1nuD/AZQKBgQC3\n6M+toA373e6zuV3BskDS4K9se85VXviu0J7Ab8j5QJwthU0g/3zAWNHAjojGEtxA\nVB9ddCTu92OhonSBK78tXGSPaV4ukyY+YzN8N0d+LmNXGpSEYb+VaPbSZ/NICUY3\nB8sybx/GCAbpvOpF6Zi9WbQ7qJnVcKCq6TVCXoxXxwKBgAjmh2RiREKPO0VgYYpV\nCcLzl+1pKvvMy/zdl/FsQ8qMmVWXHEfWqaBl/vCm3cYKYa14gvnkqys8VT97+GYT\ngr9kZVcru4MhoM6msOw2ag7aFk8G+XFTc5O3WQTSQBgGeWfXcq73XV3AM8cdQ8CJ\n+LKTCuLxVlz9W+KYGUO8R5x3\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@fleet-goal-372106.iam.gserviceaccount.com",
  "client_id": "1066957575502161865",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40fleet-goal-372106.iam.gserviceaccount.com"
}
''';

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
