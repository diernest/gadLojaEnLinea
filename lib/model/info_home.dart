import 'package:gad_loja/model/my_banner.dart';
import 'package:gad_loja/model/my_item.dart';

class InfoHome {
  late List<MyBanner> banners;
  late List<MyItem> deudas;
  late List<MyItem> serviciosMunicipales;

  InfoHome.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson);

    banners = [];
    for (int i = 0; i < parsedJson['banners'].length; i++) {
      MyBanner result = MyBanner.fromJson(parsedJson['banners'][i]);
      banners.add(result);
    }

    deudas = [];
    for (int i = 0; i < parsedJson['deudas'].length; i++) {
      MyItem result = MyItem.fromJson(parsedJson['deudas'][i]);
      deudas.add(result);
    }

    serviciosMunicipales = [];
    for (int i = 0; i < parsedJson['servicios'].length; i++) {
      MyItem result = MyItem.fromJson(parsedJson['servicios'][i]);
      serviciosMunicipales.add(result);
    }
  }
}
