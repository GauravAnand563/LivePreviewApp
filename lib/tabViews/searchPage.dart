import 'package:flutter/material.dart';

import '../videoCaraousel/caraousel_slider.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, left: 20, bottom: 50),
              child: Text(
                'Search Page',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Divider(
              height: 60,
            ),
            CarouselImages(
              // scaleFactor: 0.6,
              // viewportFraction: 0.6,
              listImages: listImages,
              height: 250,
            ),
          ],
        ),
      ),
    );
  }
}
