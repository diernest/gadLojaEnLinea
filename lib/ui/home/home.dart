import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:gad_loja/model/info_home.dart';
import 'package:gad_loja/model/my_banner.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:gad_loja/model/provider/cart.dart';
import 'package:gad_loja/persistence/api_provider.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gad_loja/ui/home/widgets/card_item.dart';
import 'package:gad_loja/ui/home/widgets/carrousel_home.dart';
import 'package:gad_loja/ui/navigation_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  dynamic parsedJsonCategories;
  late InfoHome infoHome;
  List<MyBanner> banners = [];
  List<MyItem> allServices = [];
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
              ? const SliverToBoxAdapter(child: Text("loading..."))
              : buildCarrouselHome(),
          loadingBanners
              ? const SliverToBoxAdapter(child: Text("loading..."))
              : allServices.isNotEmpty &&
                      allServices
                          .where((element) => element.value > 0)
                          .isNotEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Text(
                          "Servicios por pagar (${allServices.where((element) => element.value > 0).length})",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : const SliverToBoxAdapter(),
          loadingBanners
              ? const SliverToBoxAdapter(child: Text("loading..."))
              : allServices.isNotEmpty &&
                      allServices
                          .where((element) => element.value > 0)
                          .isNotEmpty
                  ? SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 180.0,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                        childAspectRatio: 1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return CardItem(
                              myItem: allServices
                                  .where((element) => element.value > 0)
                                  .toList()[index]);
                        },
                        childCount: allServices
                            .where((element) => element.value > 0)
                            .length,
                      ),
                    )
                  : const SliverToBoxAdapter(),
          allServices.isNotEmpty
              ? SliverToBoxAdapter(
                  child: Center(child:
                      Consumer<CartModel>(builder: (context, cart, child) {
                    return Text("Total price: ${cart.getSubtotal}");
                  })),
                )
              : const SliverToBoxAdapter(),
          loadingBanners
              ? const SliverToBoxAdapter(child: Text("loading..."))
              : allServices.isNotEmpty
                  ? SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: Text(
                          "Servicios Municipales",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : const SliverToBoxAdapter(),
          allServices.isNotEmpty
              ? SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return CardItem(myItem: allServices[index]);
                    },
                    childCount: allServices.length,
                  ),
                )
              : const SliverToBoxAdapter()
        ],
      ),
      //bottomNavigationBar: MyNavigationBar() ,
    );
  }

  Future<void> loadCategories() async {
    dynamic parsedJson;
    parsedJson = await ApiProvider.getHome();
    infoHome = InfoHome.fromJson(parsedJson);

    List<MyItem> currentCart =
        Provider.of<CartModel>(context, listen: false).myItems;

    allServices = infoHome.allServices;
    //Verifico si ya está en carrito
    for (var inCart in currentCart) {
      for (var services in allServices) {
        if (inCart.id == services.id) {
          services.isAdd = true;
        }
      }
    }

    setState(() {
      banners = infoHome.banners;
      loadingBanners = false;
    });
  }

  Widget buildCarrouselHome() {
    List<Widget> itms = [];
    for (var element in banners) {
      itms.add(MyCarrousel(url: element.url, description: element.description));
    }

    return SliverToBoxAdapter(
      child: FlutterCarousel(
          options: CarouselOptions(
            height: 160,
            showIndicator: true,
            slideIndicator: const CircularSlideIndicator(
              currentIndicatorColor: Colors.red,
            ),
          ),
          items: itms),
    );
  }
}
