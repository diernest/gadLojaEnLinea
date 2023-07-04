import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gad_loja/model/info_home.dart';
import 'package:gad_loja/model/my_banner.dart';
import 'package:gad_loja/model/my_item.dart';

import 'package:gad_loja/persistence/api_provider.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gad_loja/ui/home/widgets/card_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic parsedJsonCategories;
  late InfoHome infoHome;
  List<MyBanner> banners = [];
  List<MyItem> deudas = [];
  bool loadingBanners = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          loadingBanners
              ? SliverToBoxAdapter(child: Text("loading..."))
              : buildCarrouselHome(),
          loadingBanners
              ? SliverToBoxAdapter(child: Text("loading..."))
              : SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CardItem(myItem: deudas[index]);
                    },
                    childCount: deudas.length,
                  ),
                ),
          deudas.length > 0
              ? SliverToBoxAdapter(
                  child: Center(child: Text("Pagar")),
                )
              : SliverToBoxAdapter()
        ],
      ),
    );
  }

  Future<void> loadCategories() async {
    dynamic parsedJson;
    parsedJson = await ApiProvider.getHome();
    infoHome = InfoHome.fromJson(parsedJson);

    setState(() {
      banners = infoHome.banners;
      deudas = infoHome.deudas;
      loadingBanners = false;
    });
    print("aqui");
  }

  Widget buildCarrouselHome() {
    List<Widget> itms = [];

    banners.forEach((element) {
      itms.add(
          buildHorizontalList(url: element.url, title: element.description));
    });

    return SliverToBoxAdapter(
      child: FlutterCarousel(
          options: CarouselOptions(
            height: 240,
            showIndicator: true,
            slideIndicator: const CircularSlideIndicator(),
          ),
          items: itms),
    );
  }

  Widget buildHorizontalList({required String url, required String title}) {
    return Card(
      margin: EdgeInsets.all(8.0),
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.0),
        child: Image(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(url, maxHeight: 200)),
      ),
    );
  }
}
