import 'package:flutter/material.dart';

import '../tabViews/downloads.dart';
import '../tabViews/favourites.dart';
import '../tabViews/homePage.dart';
import '../tabViews/searchPage.dart';

class TabViews extends ChangeNotifier {
  int selectedIndex = 3;
  void setTabView(int idx) {
    selectedIndex = idx;
    notifyListeners();
  }

  Widget getTabView(BuildContext context) {
    Widget ob;
    ob = HomePage();
    switch (selectedIndex) {
      case 0:
        ob = HomePage();
        break;
      case 1:
        ob = SearchPage();
        break;
      case 2:
        ob = FavouritePage();
        break;
      case 3:
        ob = DownloadPage();
        break;
    }
    return ob;
  }
}
