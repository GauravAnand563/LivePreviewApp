import 'package:flutter/material.dart';
import '../constants.dart';

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      color: Colors.transparent,
      child: Center(
        child: Text(
          'Downloads Page',
          style: kh1,
        ),
      ),
    );
  }
}
