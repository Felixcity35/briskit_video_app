import 'package:flutter/material.dart';
import 'package:movies_app/Helpers/Constants/API_Key.dart';
import 'package:movies_app/Screens/Favorites/favourite.dart';
import 'package:movies_app/Screens/Home/movie_home.dart';
import 'package:movies_app/Screens/search/search_home.dart';
import 'package:movies_app/Screens/search/search_movie_list.dart';

import 'app.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (tabItem == Screen1)
      child = MovieHome();
    else if (tabItem == Screen2)
      child = SearchHome();
    else if (tabItem == Screen3) child = Favorites();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child!);
      },
    );
  }
}
