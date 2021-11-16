import 'dart:convert';

import 'package:julkort/model.dart';
import 'package:http/http.dart' as http;

const API_KEY = 'b9948f8b-4782-41bc-ada3-b7790e78efcf';
const API_URL = 'https://julkort-api-qhvxn.ondigitalocean.app';

class Api {
  static Future<List<ChristmasCard>> addCard(ChristmasCard card) async {
    Map<String, dynamic> json = ChristmasCard.toJson(card);
    var bodyString = jsonEncode(json);
    var response = await http.post(
      Uri.parse('$API_URL/julkort?key=$API_KEY'),
      body: bodyString,
      headers: {'Content-Type': 'application/json'},
    );
    bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ChristmasCard>((data) {
      return ChristmasCard.fromJson(data);
    }).toList();
  }

  static Future deleteCard(String cardId) async {
    var response = await http.delete(
        Uri.parse('$API_URL/julkort/$cardId?key=$API_KEY&_confirm=true'));
    var bodyString = response.body;
    var list = jsonDecode(bodyString);

    return list.map<ChristmasCard>((data) {
      return ChristmasCard.fromJson(data);
    }).toList();
  }

  static Future<List<ChristmasCard>> getCards() async {
    var response = await http.get(Uri.parse('$API_URL/julkort?key=$API_KEY'));
    String bodyString = response.body;
    print(bodyString);
    var json = jsonDecode(bodyString);

    return json.map<ChristmasCard>((data) {
      return ChristmasCard.fromJson(data);
    }).toList();
  }
}
