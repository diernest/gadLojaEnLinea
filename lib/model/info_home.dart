import 'package:gad_loja/model/my_banner.dart';
import 'package:gad_loja/model/my_item.dart';

class InfoHome {
  late List<MyBanner> banners;
  late List<MyItem> debts;
  late List<MyItem> allServices;

  InfoHome.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);
    banners = [];
    for (int i = 0; i < parsedJson['banners'].length; i++) {
      MyBanner result = MyBanner.fromJson(parsedJson['banners'][i]);
      banners.add(result);
    }

    debts = [];
    for (int i = 0; i < parsedJson['deudas'].length; i++) {
      MyItem result = MyItem.fromJson(parsedJson['deudas'][i]);
      debts.add(result);
    }

    allServices = [];
    for (int i = 0; i < parsedJson['servicios'].length; i++) {
      MyItem result = MyItem.fromJson(parsedJson['servicios'][i]);
      allServices.add(result);
    }
  }
}
