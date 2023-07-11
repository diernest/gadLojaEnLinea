import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gad_loja/model/info_home.dart';
import 'package:gad_loja/model/my_banner.dart';
import 'package:gad_loja/model/my_item.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:gad_loja/ui/home/cubit/home_cubic.dart';
import 'package:gad_loja/ui/home/cubit/home_state.dart';
import 'package:gad_loja/ui/home/widgets/card_item.dart';
import 'package:gad_loja/ui/home/widgets/carrousel_home.dart';

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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<HomeCubit>();
      cubit.fetchHome();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state){
          if (state is InitHomeState || state is LoadingHomeState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is ResponseHomeState){
            return CustomScrollView(
              slivers: [
                  buildCarrouselHome(state.infoHome.banners),
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 1.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                      return CardItem(myItem: state.infoHome.allServices[index]);
                    },
                    childCount: state.infoHome.allServices.length,
                  ),
                )
              ],
            );
          }else if(state is ErrorHomeState){
            return Center(child: Text(state.msjError),);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      //bottomNavigationBar: MyNavigationBar() ,
    );
  }

  Widget buildCarrouselHome(List<MyBanner> banners) {
    List<Widget> items = [];
    for (var element in banners) {
      items.add(MyCarrousel(url: element.url, description: element.description));
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
          items: items),
    );
  }
}
