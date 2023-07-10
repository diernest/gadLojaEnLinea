import 'package:gad_loja/model/info_home.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:gad_loja/persistence/api_provider.dart';

class GadRepository{

  Future<InfoHome> getAll() async {
    if(true) {
      dynamic parsedJson = await ApiProvider.getHome();
      return InfoHome.fromJson(parsedJson);

    }else{
      throw "Ocurrio un error";
    }
  }


}