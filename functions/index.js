const functions = require("firebase-functions");
const {google} = require("googleapis");
const serviceAccount = require("./serviceAccount.json");
const axios = require("axios");

exports.updateGoogleSheets = functions.firestore
    .document("orders/{orderId}")
    .onCreate(async (snap, context) => {
      const data = snap.data();

      const jwtClient = new google.auth.JWT({
        email: serviceAccount.client_email,
        key: serviceAccount.private_key,
        scopes: "https://www.googleapis.com/auth/spreadsheets",
      });

      const jwtAuthPromise = jwtClient.authorize();

      await jwtAuthPromise;

      const service = google.sheets({version: "v4", auth: jwtClient});
      const values = [[
        data.orderId,
        data.finalTotal,
        data.customerInformation.name,
        data.customerInformation.email,
        data.customerInformation.phone,
        data.customerInformation.dietaryRequirements,
        data.customerInformation.address.fullAddress,
        data.customerInformation.address.gmapsURL,
        data.orderInformation.mealsWanted,
        data.orderInformation.selectedDates,
        data.orderInformation.selectedMeals,
        data.orderInformation.numberOfSets,
        data.notes,
      ]];

      const result = await service.spreadsheets.values.append({
        spreadsheetId: "1lylaM1zQdOtgBCnXGSHP-9Esdxd7_tBVcL6t1uofIW8",
        range: "Order Information!A3:P",
        valueInputOption: "RAW",
        requestBody: {
          values,
        },
      });
      console.log("%d cells updated.", result.data.updatedCells);
      return result;
    });

exports.locationAutofill = functions.https.onCall(async (data) => {
  const googleAPIKey = serviceAccount.google_places_api_key;

  const requestURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+ data + "&key=" + googleAPIKey;

  return await axios.default.get(requestURL).then((apiResponse) => {
    return {predictions: apiResponse.data.predictions};
  }).catch((error) => {
    console.log(error);
  });
});

exports.getLatLng = functions.https.onCall(async (placeId) => {
  const googleAPIKey = serviceAccount.google_places_api_key;

  const requestURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+ placeId + "&key=" + googleAPIKey;

  return await axios.default.get(requestURL).then((apiResponse) => {
    return apiResponse.data.result.geometry.location;
  }).catch((error) => {
    console.log(error);
  });
});

exports.testFunction = functions.https.onCall(() => {});
