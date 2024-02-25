import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyCarrousel extends StatelessWidget {
  final String url;
  final String description;
  const MyCarrousel({super.key, required this.url, required this.description});

  @override
  Widget build(BuildContext context) {
    final widthBanner = MediaQuery.of(context).size.width - 16;
    return Container(
      width: widthBanner,
      color: Colors.transparent,
      child: Card(
        elevation: 0,
        shadowColor: Colors.transparent,
        margin: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28.0),
          child: Image(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(url)
          ),
        ),
      ),
    );
  }
}
