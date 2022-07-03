import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:livepreview/theme.dart';
import 'package:livepreview/widgets/frostedGlassIcon.dart';
import 'constants.dart';
import 'tabViews/homePage.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'widgets/bottomNavigationBarButton.dart';
import 'package:ionicons/ionicons.dart';

import 'models/tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  bool isFABVisible = true;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: isFABVisible &&
                Provider.of<TabViews>(context, listen: false).selectedIndex == 0
            ? Container(
                margin: EdgeInsets.only(bottom: 60),
                // alignment: Alignment.topRight,
                child: FrostedGlassIcon(
                  child: Icon(
                    themeProvider.isDarkMode
                        ? CupertinoIcons.sun_max
                        : CupertinoIcons.moon_stars,
                    color: Colors.red,
                  ),
                  onTap: () {
                    themeProvider.toggleTheme();
                  },
                ),
              )
            : null,
        body: Stack(
          children: [
            Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary
                    ],
                    // colors: [Colors.yellow, Colors.red,Colors.purple],
                    center: Alignment(-1.2, -0.6),
                    focal: Alignment(0.3, -0.1),
                    focalRadius: 1,
                  ),
                )),
            Column(
              children: [
                Expanded(
                    flex: 10,
                    child: NotificationListener<UserScrollNotification>(
                        onNotification: (notification) {
                          if (notification.direction ==
                              ScrollDirection.forward) {
                            if (!isFABVisible)
                              setState(() {
                                isFABVisible = true;
                              });
                          } else if (notification.direction ==
                              ScrollDirection.reverse) {
                            if (isFABVisible)
                              setState(() {
                                isFABVisible = false;
                              });
                          }
                          return true;
                        },
                        child: Provider.of<TabViews>(context)
                            .getTabView(context))),
                Expanded(
                  child: Container(
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          // color: Colors.grey.withOpacity(0.01),
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                BottomNavigationBarButtons(
                                    icon: Provider.of<TabViews>(context,
                                                    listen: false)
                                                .selectedIndex ==
                                            0
                                        ? Ionicons.home
                                        : Ionicons.home_outline,
                                    index: 0),
                                BottomNavigationBarButtons(
                                    icon: Provider.of<TabViews>(context,
                                                    listen: false)
                                                .selectedIndex ==
                                            1
                                        ? Ionicons.search
                                        : Ionicons.search_outline,
                                    index: 1),
                                BottomNavigationBarButtons(
                                    icon: Provider.of<TabViews>(context,
                                                    listen: false)
                                                .selectedIndex ==
                                            2
                                        ? Ionicons.bookmark
                                        : Ionicons.bookmark_outline,
                                    index: 2),
                                BottomNavigationBarButtons(
                                    icon: Provider.of<TabViews>(context,
                                                    listen: false)
                                                .selectedIndex ==
                                            3
                                        ? Ionicons.download
                                        : Ionicons.download_outline,
                                    index: 3),
                              ]),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
