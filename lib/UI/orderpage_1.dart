import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';

import 'package:withes_webapp/UI/orderpage_2.dart';
import 'package:withes_webapp/Utility/config.dart';
import 'package:withes_webapp/Utility/gsheets_service.dart';

class OrderPage1 extends StatefulWidget {
  const OrderPage1({super.key});

  @override
  State<OrderPage1> createState() => _OrderPage1State();
}

class _OrderPage1State extends State<OrderPage1> {
  orderProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Stack(children: [
        const SizedBox(
          height: 40,
          child: Center(
            child: LinearProgressIndicator(
              value: 0.25,
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 4),
                      shape: BoxShape.circle),
                  child: const Center(
                    child: Text('2',
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
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
            SizedBox(
                width: screenSize.width * 0.45, child: const CalendarWidget()),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
                width: screenSize.width * 0.45,
                child: const CustomerDataFormWidget())
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
                width: screenSize.width * 0.9, child: const CalendarWidget()),
            const SizedBox(height: 20),
            SizedBox(
                width: screenSize.width * 0.9,
                child: const CustomerDataFormWidget())
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

//    _____      _                _
//   / ____|    | |              | |
//  | |     __ _| | ___ _ __   __| | __ _ _ __
//  | |    / _` | |/ _ \ '_ \ / _` |/ _` | '__|
//  | |___| (_| | |  __/ | | | (_| | (_| | |
//   \_____\__,_|_|\___|_| |_|\__,_|\__,_|_|

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 12, left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Which days would you like food delivered?",
                  style: appTheme.textTheme.headlineSmall,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 12),
                alignment: Alignment.centerRight,
                child: const Tooltip(
                  message: 'Help',
                  child: CalendarHelp(),
                ),
              ),
            ],
          ),
          const DatePicker()
        ],
      ),
    );
  }
}

class CalendarHelp extends StatefulWidget {
  const CalendarHelp({super.key});

  @override
  State<CalendarHelp> createState() => _CalendarHelpState();
}

class _CalendarHelpState extends State<CalendarHelp> {
  _helpDialog(BuildContext context) {
    String deliveryDays = '';

    checkFinal(currentIndex) {
      if (currentIndex == (deliveryDates.length - 2)) {
        deliveryDays += ' and ';
      } else if (currentIndex < (deliveryDates.length - 1)) {
        deliveryDays += ', ';
      }
      return deliveryDays;
    }

    for (var i = 0; i < deliveryDates.length; i++) {
      switch (deliveryDates[i]) {
        case 0:
          deliveryDays += 'Sunday';
          checkFinal(i);
          break;
        case 1:
          deliveryDays += 'Monday';
          checkFinal(i);
          break;
        case 2:
          deliveryDays += 'Tuesday';
          checkFinal(i);
          break;
        case 3:
          deliveryDays += 'Wednesday';
          checkFinal(i);
          break;
        case 4:
          deliveryDays += 'Thursday';
          checkFinal(i);
          break;
        case 5:
          deliveryDays += 'Friday';
          checkFinal(i);
          break;
        case 6:
          deliveryDays += 'Saturday';
          checkFinal(i);
          break;
      }
    }

    Widget okButton = TextButton(
      onPressed: Navigator.of(context).pop,
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      content: Text(
        'Select the dates you want food delivered and click OK to confirm.\n\n'
        'Please note that we are only delivering on $deliveryDays',
        style: const TextStyle(height: 1.5),
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

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  List<dynamic> availableDates = [];
  final _weekdayLabelTextStyle = const TextStyle(
    color: Color(0xFF0a8ea0),
    fontWeight: FontWeight.w600,
  );
  final _dayTextStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
  final _weekendTextStyle =
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600);

  asyncInitState() async {
    availableDates = [];
    var allDates = await AvailableDatesManager().getAll();
    List compiledDates = [];

    for (var i = 0; i < allDates.length; i++) {
      if (!availableDates.contains(allDates[i].date.toString())) {
        availableDates.add(allDates[i].date.toString());
      }
    }
    return availableDates;
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
          Text('Please wait while we load . . .',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
        ],
      )),
    );
  }

  _dayTextStylePredicate(date) {
    TextStyle? textStyle;
    if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday) {
      textStyle = _weekendTextStyle;
    }
    return textStyle;
  }

  _firstDate() {
    //Ensure datepicker starts next week
    var newDate = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(newDate);
    newDate = DateTime.parse(formattedDate);
    var numOfDaysToAdd = 8 - newDate.weekday;

    return newDate.add(Duration(days: numOfDaysToAdd));
  }

  _selectableDayPredicate(DateTime date) {
    //Define days delivery is available
    for (var i = 0; i < availableDates.length; i++) {
      if (date.compareTo(DateTime.parse(availableDates[i])) == 0) {
        return true;
      }
    }
    return false;
  }

  _selectedDates(List dateList) {
    var formatedDates = [];
    var finalList = '';

    for (var i = 0; i < dateList.length; i++) {
      //Convert DateTime to String
      formatedDates.add(DateFormat.MMMMEEEEd().format(dateList[i]));
    }

    for (var i = 0; i < formatedDates.length; i++) {
      // Convert StringList into String
      finalList += '\n  - ${formatedDates[i]}';
    }

    return finalList;
  }

  _dateConfirmationDialog(BuildContext context) {
    String dialogText = '';

    if (OrderData.selectedDates.isEmpty) {
      dialogText = 'No dates were selected';
    } else {
      var dateList = _selectedDates(OrderData.selectedDates);
      dialogText = 'You\'ve selected the following dates:' '$dateList';
    }

    Widget okButton = TextButton(
      onPressed: Navigator.of(context).pop,
      child: const Text('OK'),
    );

    AlertDialog alert = AlertDialog(
      content: Text(
        dialogText,
        style: const TextStyle(height: 1.5),
      ),
      actions: [okButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        if (OrderData.selectedDates.isEmpty) {
          return alert;
        } else {
          return alert;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: asyncInitState(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return CalendarDatePicker2WithActionButtons(
              config: CalendarDatePicker2WithActionButtonsConfig(
                firstDate: _firstDate(),
                firstDayOfWeek: 0,
                calendarType: CalendarDatePicker2Type.multi,
                weekdayLabelTextStyle: _weekdayLabelTextStyle,
                dayTextStyle: _dayTextStyle,
                selectableDayPredicate: (date) => _selectableDayPredicate(date),
                dayTextStylePredicate: ({required date}) =>
                    _dayTextStylePredicate(date),
              ),
              initialValue: const [],
              onValueChanged: (value) => setState(() {
                OrderData.selectedDates = value;
                _dateConfirmationDialog(context);
              }),
            );
          } else {
            return progressIndicator();
          }
        });
  }
}

//    _____            _____        _
//   / ____|          |  __ \      | |
//  | |    _   _ ___  | |  | | __ _| |_ __ _
//  | |   | | | / __| | |  | |/ _` | __/ _` |
//  | |___| |_| \__ \ | |__| | (_| | || (_| |
//   \_____\__,_|___/ |_____/ \__,_|\__\__,_|

class CustomerDataFormWidget extends StatelessWidget {
  const CustomerDataFormWidget({super.key});

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
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 12, left: 20, bottom: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "Please provide your information bellow",
              style: appTheme.textTheme.headlineSmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 22),
            child: NameField(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 5),
            child: PhoneField(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 22),
            child: EmailField(),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 15),
            child: AddressField(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 22),
            child: NumOfSetsField(),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, right: 25, bottom: 10),
            child: ConfirmButton(),
          ),
        ],
      ),
    );
  }
}

class NameField extends StatefulWidget {
  const NameField({super.key});

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          filled: true,
          icon: Icon(Icons.person),
          hintText: 'How should we call you?',
          labelText: 'Name'),
      keyboardType: TextInputType.name,
      onChanged: (text) {
        OrderData.customerName = text;
      },
    );
  }
}

class EmailField extends StatefulWidget {
  const EmailField({super.key});

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          filled: true,
          icon: Icon(Icons.email),
          hintText: 'Your email address',
          labelText: 'Email'),
      keyboardType: TextInputType.emailAddress,
      onChanged: (text) {
        OrderData.customerEmail = text;
      },
    );
  }
}

class PhoneField extends StatefulWidget {
  const PhoneField({super.key});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
          filled: true,
          icon: Icon(Icons.phone),
          hintText: 'Where can we reach you?',
          labelText: 'Phone Number',
          prefixText: '+61'),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      maxLength: 10,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      onChanged: (text) {
        if (text[0] == '0') {
          OrderData.customerPhone = '+61' + text.substring(1);
        } else {
          OrderData.customerPhone = '+61' + text;
        }
      },
    );
  }
}

class AddressField extends StatefulWidget {
  const AddressField({super.key});

  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  String? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            filled: true,
            icon: Icon(Icons.home),
            labelText: 'Address Line 1',
          ),
          onChanged: (text) {
            OrderData.addLine1 = text;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: TextFormField(
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Suburb',
            ),
            onChanged: (text) {
              OrderData.addSuburb = text;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: TextFormField(
            decoration: const InputDecoration(
              filled: true,
              labelText: 'Postcode',
            ),
            onChanged: (text) {
              OrderData.addPostcode = text;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: TextFormField(
            decoration: const InputDecoration(
              filled: true,
              labelText: 'State',
            ),
            onChanged: (text) {
              OrderData.addState = text;
            },
          ),
        ),
      ],
    );
  }
}

//    _____      _                                          _
//   / ____|    | |       /\                               | |
//  | (___   ___| |_     /  \   _ __ ___   ___  _   _ _ __ | |_
//   \___ \ / _ \ __|   / /\ \ | '_ ` _ \ / _ \| | | | '_ \| __|
//   ____) |  __/ |_   / ____ \| | | | | | (_) | |_| | | | | |_
//  |_____/ \___|\__| /_/    \_\_| |_| |_|\___/ \__,_|_| |_|\__|

class NumOfSetsWidget extends StatelessWidget {
  const NumOfSetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
      child: const Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
        child: NumOfSetsField(),
      ),
    );
  }
}

class NumOfSetsField extends StatefulWidget {
  const NumOfSetsField({super.key});

  @override
  State<NumOfSetsField> createState() => _NumOfSetsFieldState();
}

class _NumOfSetsFieldState extends State<NumOfSetsField> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Text(
        'Number of Sets',
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      CustomNumberPicker(
        initialValue: 1,
        maxValue: 100,
        minValue: 1,
        step: 1,
        onValue: (num value) {
          OrderData.numOfSets = value;
        },
      ),
    ]);
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

    if (OrderData.customerName.isEmpty) {
      errorMessage += 'Please input your name.\n';
    }

    if (OrderData.customerEmail.isEmpty) {
      errorMessage += 'Please input your email.\n';
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(OrderData.customerEmail)) {
      } else {
        errorMessage += 'Please input a valid email.\n';
      }
    }

    if (OrderData.customerPhone.isEmpty) {
      errorMessage += 'Please input your contact number.\n';
    }

    if (OrderData.addLine1.isEmpty ||
        OrderData.addSuburb.isEmpty ||
        OrderData.addPostcode.isEmpty ||
        OrderData.addState.isEmpty) {
      errorMessage += 'Please input your delivery address.\n';
    }

    if (OrderData.selectedDates.isEmpty) {
      errorMessage += 'Please select the dates you want meals delivered.\n';
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
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const OrderPage2()));
        } else {
          _errorDialog(context, dataCheckResult);
        }
      },
    );
  }
}
