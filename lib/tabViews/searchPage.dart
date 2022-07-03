import 'package:flutter/material.dart';
import '../videoCaraousel/caraousel_slider.dart';
import '../widgets/videoMiniPlayer.dart';

import '../constants.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final List<String> listImages = [
    'https://picsum.photos/912/389',
    'https://picsum.photos/912/389',
    'https://picsum.photos/912/389',
    'https://picsum.photos/912/389',
    'https://picsum.photos/912/389',
    'https://picsum.photos/912/389',
    'https://picsum.photos/912/389',
    'https://picsum.photos/912/389',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.transparent,
      child: Center(
        child: CarouselImages(
          // scaleFactor: 0.6,
          // viewportFraction: 0.6,
          listImages: listImages,
          height: 250,
        ),
      ),
    );
  }
}
