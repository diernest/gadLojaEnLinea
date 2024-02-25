import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' as localdata;

class URLS {
  //URLS Produccion
  static const String BASE_URL_API = 'https://.....';
  static const String API_KEY = 'XXXXXXXXXXXXX';
  static const String DOMAIN = 'app........';
}

class ApiProvider {
  static Future<dynamic> getHome() async {
    var parsedJson = await localdata.rootBundle
        .loadString('assets/json/getHomeGad.json');
    return json.decode(parsedJson);
  }

}