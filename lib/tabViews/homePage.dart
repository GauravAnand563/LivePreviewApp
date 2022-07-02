import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livepreview/widgets/frostedGlassIcon.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  // late ScrollController _scrollController;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Container(
      color: Colors.transparent,
      constraints: BoxConstraints.expand(),
      child: Column(
        children: [
          Container(
            height: 50,
            color: Colors.red,
            width: double.infinity,
            child: Container(
              margin: EdgeInsets.only(top: 20, right: 20),
              alignment: Alignment.topRight,
              child: FrostedGlassIcon(
                child: Icon(
                  themeProvider.isDarkMode
                      ? CupertinoIcons.sun_max
                      : CupertinoIcons.moon_stars,
                  color: Colors.white,
                ),
                onTap: () {
                  themeProvider.toggleTheme();
                },
              ),
            ),
          ),
          ListView.builder(
            // controller: _scrollController,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                color: Color.fromARGB(255, 141, 110, 146),
                margin: (index == 0)
                    ? EdgeInsets.fromLTRB(20, 100, 20, 20)
                    : EdgeInsets.all(20),
                height: 100,
                width: double.infinity,
                child: Text(
                  'Hello World!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
