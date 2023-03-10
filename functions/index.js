const functions = require("firebase-functions");
const {google} = require("googleapis");
const axios = require("axios");
const stripe = require("stripe")(functions.config().stripe.token);

exports.updateGoogleSheets = functions.firestore
    .document("orders/{orderId}")
    .onCreate(async (snap, context) => {
      const data = snap.data();

      const jwtClient = new google.auth.JWT({
        email: functions.config().gsheets.email,
        key: functions.config().gsheets.token,
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
        spreadsheetId: functions.config().gsheets.spreadsheetid,
        range: functions.config().gsheets.sheetrange,
        valueInputOption: "RAW",
        requestBody: {
          values,
        },
      });
      console.log("%d cells updated.", result.data.updatedCells);
      return result;
    });

exports.locationAutofill = functions.https.onCall(async (data) => {
  const googleAPIKey = functions.config().gplaces.token;

  const requestURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="+ data + "&key=" + googleAPIKey;

  return await axios.default.get(requestURL).then((apiResponse) => {
    return {predictions: apiResponse.data.predictions};
  }).catch((error) => {
    console.log(error);
  });
});

exports.getLatLng = functions.https.onCall(async (placeId) => {
  const googleAPIKey = functions.config().gplaces.token;

  const requestURL = "https://maps.googleapis.com/maps/api/place/details/json?placeid="+ placeId + "&key=" + googleAPIKey;

  return await axios.default.get(requestURL).then((apiResponse) => {
    return apiResponse.data.result.geometry.location;
  }).catch((error) => {
    console.log(error);
  });
});

exports.stripePayment = functions.https.onCall(async (data) => {
  const createPaymentMethod = await stripe.paymentMethods.create({
    type: "card",
    card: data.card,
  });

  const createPaymentIntent = await stripe.paymentIntents.create({
    amount: data.amount,
    currency: "aud",
    payment_method_types: ["card"],
    description: `Payment for order ${data.orderId}`,
  });

  const confirmPaymentIntent = await stripe.paymentIntents.confirm(
      createPaymentIntent.id,
      {payment_method: createPaymentMethod.id,
        receipt_email: data.receipt_email},
  );

  return confirmPaymentIntent.status;
});

exports.testFunction = functions.https.onCall(() => {});
