import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livepreview/widgets/frostedGlassIcon.dart';
import 'package:livepreview/widgets/videoMiniPlayer.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // late ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return ListView.builder(
      itemCount: 10,
      // controller: _scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          color: Color.fromARGB(255, 141, 110, 146),
          margin: (index == 0)
              ? EdgeInsets.fromLTRB(0, 100, 0, 0)
              : EdgeInsets.all(0),
          // child: VideoMiniPlayer(),
        );
      },
    );
  }
}
