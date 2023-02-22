import 'package:cloud_functions/cloud_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:withes_webapp/Utility/config.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceAutocomplete {
  Future<List<Suggestion>> fetchSuggestions(String input) async {
    var data = input.replaceAll(RegExp('\\s+'), '%20');
    List<Suggestion> output = [];
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('locationAutofill')
          .call(data);
      for (var i = 0; i < result.data['predictions'].length; i++) {
        output.add(Suggestion(result.data['predictions'][i]['place_id'],
            result.data['predictions'][i]['description']));
      }
    } on FirebaseFunctionsException catch (error) {
      print("Error: ${error.message}");
    }
    return output;
  }

  getLatLng(String placeId) async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getLatLng')
          .call(placeId);
      print(result.data);
      OrderData.lat = result.data['lat'].toString();
      OrderData.lng = result.data['lng'].toString();
      return LatLng(result.data['lat'], result.data['lng']);
    } on FirebaseFunctionsException catch (error) {
      print("Error: ${error.message}");
    }
  }
}
