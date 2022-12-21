import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:withes_webapp/Utility/config.dart';

class OrderPage1 extends StatelessWidget {
  const OrderPage1({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final screenSize = MediaQuery.of(context).size;

    buildWebView() {
      return Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
              controller: scrollController,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: screenSize.width * 0.45,
                      child: const CalendarWidget()),
                  SizedBox(
                      width: screenSize.width * 0.45,
                      child: const CustomerDataFormWidget())
                ],
              )));
    }

    buildMobileView() {
      return Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
              controller: scrollController,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: screenSize.width * 0.8,
                        child: const CalendarWidget()),
                    const SizedBox(height: 20),
                    SizedBox(
                        width: screenSize.width * 0.8,
                        child: const CustomerDataFormWidget())
                  ],
                ),
              )));
    }

    return Container(
      padding: const EdgeInsets.all(50),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1000) {
          return buildWebView();
        } else {
          return buildMobileView();
        }
      }),
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
                  style: appTheme.textTheme.headline5,
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
  final _weekdayLabelTextStyle = const TextStyle(
    color: Color(0xFF0a8ea0),
    fontWeight: FontWeight.w600,
  );
  final _dayTextStyle =
      const TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
  final _weekendTextStyle =
      const TextStyle(color: Colors.grey, fontWeight: FontWeight.w600);

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
    for (var i = 0; i < deliveryDates.length; i++) {
      if (date.weekday == deliveryDates[i]) {
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
        print(OrderData.selectedDates);
        _dateConfirmationDialog(context);
      }),
    );
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
              style: appTheme.textTheme.headline5,
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
          const Padding(
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

//    _____ __  __
//   / ____|  \/  |
//  | |  __| \  / | __ _ _ __  ___
//  | | |_ | |\/| |/ _` | '_ \/ __|
//  | |__| | |  | | (_| | |_) \__ \
//   \_____|_|  |_|\__,_| .__/|___/
//                      | |
//                      |_|

class AddressField extends StatefulWidget {
  const AddressField({super.key});

  @override
  State<AddressField> createState() => _AddressFieldState();
}

class _AddressFieldState extends State<AddressField> {
  final _controller = TextEditingController();

  late GoogleMapController mapController;
  LatLng addressCoord = const LatLng(-31.93044189148321, 115.86103545527742);
  final CameraPosition _kGoogle = const CameraPosition(
      target: LatLng(-31.93044189148321, 115.86103545527742), zoom: 10);

  final List<Marker> _markers = <Marker>[];

  void _updateGMapsMarker() {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
          markerId: MarkerId(OrderData.address), position: addressCoord));
    });
  }

  void _updateCameraPosition() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: addressCoord, zoom: 15),
    ));
    mapController.setMapStyle('[]');
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            filled: true,
            icon: Icon(Icons.home),
            hintText: 'Enter your shipping address',
            labelText: 'Address',
          ),
          onTap: () async {
            var place = await PlacesAutocomplete.show(
                context: context,
                apiKey: kGoogleApiKey,
                mode: Mode.overlay,
                onError: (error) {
                  print(error);
                });
            if (place != null) {
              setState(() {
                OrderData.address = place.description.toString();
                _controller.text = OrderData.address;
              });
              final pList = GoogleMapsPlaces(
                  apiKey: kGoogleApiKey,
                  apiHeaders: await const GoogleApiHeaders().getHeaders());
              String placeId = place.placeId ?? '0';
              final detail = await pList.getDetailsByPlaceId(placeId);
              final geometry = detail.result.geometry!;
              OrderData.lat = geometry.location.lat.toString();
              OrderData.lang = geometry.location.lng.toString();
              addressCoord =
                  LatLng(geometry.location.lat, geometry.location.lng);
              _updateGMapsMarker();
              _updateCameraPosition();
            }
          },
        ),
        Container(
            padding: const EdgeInsets.only(top: 10),
            height: 300,
            child: GoogleMap(
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                initialCameraPosition: _kGoogle,
                markers: Set<Marker>.of(_markers)))
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

    if (OrderData.address.isEmpty) {
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
