import 'package:flutter/material.dart';

import '../constants.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.transparent,
      child: Center(
        child: Text(
          'Favourites Page',
          style: kh1,
        ),
      ),
    );
  }
}
