import 'dart:math';
import 'package:gad_loja/model/category.dart';

class Sucursal {
  late int companyId;
  late String message;
  late String name;
  late String address;
  late String phone;
  late List<Category> categorias;
  late double shipping;
  late bool acceptTC;
  bool onlinePayment = false;
  late double longitude;
  late double latitude;
  bool opt_pickup = false;
  bool opt_delivery = false;
  late String isOpen;
  late String availabilityMsg;
  late bool temporarilyClosed;
  late int estimatedTimeOfArrival;
  Sucursal.fromJson(Map<String, dynamic> parsedJson) {
    //print(parsedJson);

    this.companyId = parsedJson['shop']['companyId'];
    this.message = parsedJson['shop']['message']??"";
    this.name = parsedJson['shop']['name']??"";
    this.address = parsedJson['shop']['address']??"";
    this.phone = parsedJson['shop']['phone']??"";
    this.isOpen = parsedJson['shop']['isOpen'] ?? "1";
    this.availabilityMsg = parsedJson['shop']['availabilityMsg'] ?? "";
    if (parsedJson['shop']['acceptTC'] == 1 ||
        parsedJson['shop']['acceptTC'] == 0) {
      this.acceptTC = parsedJson['shop']['acceptTC'] == 1 ? true : false;
    } else {
      this.acceptTC = parsedJson['shop']['acceptTC'];
    }
    if (parsedJson['shop']['onlinePayment'] != null) {
      this.onlinePayment = parsedJson['shop']['onlinePayment'];
    }

    if (parsedJson['shop']['location'] != null) {
      this.latitude = parsedJson['shop']['location']['lat'];
      this.longitude = parsedJson['shop']['location']['long'];
    }

    if (parsedJson['shop']['deliveryOption'] != null) {
      if (parsedJson['shop']['deliveryOption']['pickup'] != null) {
        this.opt_pickup = parsedJson['shop']['deliveryOption']['pickup'];
      }

      if (parsedJson['shop']['deliveryOption']['delivery'] != null) {
        this.opt_delivery = parsedJson['shop']['deliveryOption']['delivery'];
      }
    }

    //TODO, diernest borrar en produccion
    //this.acceptTC = true;
    //this.onlinePayment = true;
    //this.opt_pickup = false;
    //this.opt_delivery = false;
    //todo, diernest, fin borrar en produccion

    List<Category> categorias = [];
    if (parsedJson['count'] > 0) {
      //List<Category> categorias = [];
      for (int i = 0; i < parsedJson['rows'].length; i++) {
        Category result = Category.fromJson(parsedJson['rows'][i]);
        categorias.add(result);
      }
      categorias.sort((a, b) => a.prioridad.compareTo(b.prioridad));
      //this.categorias = categorias;
    }
    this.categorias = categorias;
    double value = getDouble(parsedJson['shop']['shipping'][0]['rateplans'][0]
        ['productRatePlanCharges'][0]['price']);
    double taxes = getDouble(parsedJson['shop']['shipping'][0]['rateplans'][0]
            ['productRatePlanCharges'][0]['price']) *
        getDouble(parsedJson['shop']['shipping'][0]['rateplans'][0]
            ['productRatePlanCharges'][0]['tax']);
    String taxMode = parsedJson['shop']['shipping'][0]['rateplans'][0]
        ['productRatePlanCharges'][0]['taxMode'];
    if (taxMode == 'inclusive') {
      this.shipping = roundDouble(value, 2);
    } else {
      this.shipping = roundDouble(value + taxes, 2);
    }
    this.temporarilyClosed = parsedJson['shop']['temporarilyClosed'] ?? false;
    this.estimatedTimeOfArrival = parsedJson['shop']['etaMinutes'] ?? 0;

  }

  double getDouble(dynamic value) {
    return (value ?? 0) is int ? (value ?? 0).toDouble() : (value ?? 0.0);
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
