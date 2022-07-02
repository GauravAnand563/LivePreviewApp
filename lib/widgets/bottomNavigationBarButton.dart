import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/tabs.dart';
import '../theme.dart';

class BottomNavigationBarButtons extends StatefulWidget {
  BottomNavigationBarButtons(
      {Key? key, required this.icon, required this.index})
      : super(key: key);
  IconData icon;
  int index;
  @override
  State<BottomNavigationBarButtons> createState() =>
      _BottomNavigationBarButtonsState();
}

class _BottomNavigationBarButtonsState
    extends State<BottomNavigationBarButtons> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Provider.of<TabViews>(context, listen: false).setTabView(widget.index);
      },
      child: Container(
        //show gradient with circular border
        decoration: (!themeProvider.isDarkMode &&
                Provider.of<TabViews>(context).selectedIndex == widget.index)
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                    colors: [Color(0xff148DE5), Color(0xff4FB2F9)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft),
              )
            : BoxDecoration(),
        height: 40,
        width: 40,
        child: Icon(
          widget.icon,
          size: Provider.of<TabViews>(context).selectedIndex == widget.index
              ? 19
              : 18,
          color: Provider.of<TabViews>(context).selectedIndex == widget.index
              ? Theme.of(context).iconTheme.color
              : Colors.grey,
        ),
      ),
    );
  }
}
