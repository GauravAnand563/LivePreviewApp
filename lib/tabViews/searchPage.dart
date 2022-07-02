import 'package:flutter/material.dart';

import '../constants.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: Colors.transparent,
      child: Center(
        child: Text(
          'Search Page',
          style: kh1,
        ),
      ),
    );
  }
}
