// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

import 'package:custom_navigator/custom_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:custom_navigator/custom_scaffold.dart';
import 'package:movies_app/Helpers/Constants/API_Key.dart';
import 'package:movies_app/Screens/Favorites/favourite.dart';
import 'package:movies_app/Screens/Home/movie_home.dart';
import 'package:movies_app/Screens/search/search_home.dart';

import 'tab_navigator.dart';

class NormalBottomNavBar extends StatefulWidget {
  NormalBottomNavBar({Key? key}) : super(key: key);

  @override
  NormalBottomNavBarState createState() => NormalBottomNavBarState();
}

class NormalBottomNavBarState extends State<NormalBottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    MovieHome(),
    SearchHome(),
    Favorites(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: Screen1,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            label: Screen2,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.favorite),
            label: Screen3,
          ),
        ],
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  String _currentPage = Screen1!;
  List<String> pageKeys = [Screen1!, Screen2!, Screen3!];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    Screen1!: GlobalKey<NavigatorState>(),
    Screen2!: GlobalKey<NavigatorState>(),
    Screen3!: GlobalKey<NavigatorState>(),
  };
  int _selectedIndex = 0;

  void _selectTab(String tabItem, int index) {
    if (tabItem == _currentPage) {
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != Screen1) {
            _selectTab(Screen1!, 1);
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(Screen1!),
          _buildOffstageNavigator(Screen2!),
          _buildOffstageNavigator(Screen3!),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) {
            _selectTab(pageKeys[index], index);
          },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: Screen1,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              label: Screen2,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              label: Screen3,
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: Screen1,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: Screen2,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: Screen3,
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MovieHome(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: SearchHome(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: Favorites(),
              );
            });
          default:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: MovieHome(),
              );
            });
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Widget> _children = [
    MovieHome(),
    SearchHome(),
    Favorites(),
  ];
  Widget _page = MovieHome();
  int _currentIndex = 0;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      scaffold: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              label: Screen1,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.search),
              label: Screen2,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.favorite),
              label: Screen3,
            ),
          ],
        ),
      ),
      children: <Widget>[
        MovieHome(),
        SearchHome(),
        Favorites(),
      ],
      onItemTap: (index) {},
    );
  }
}

class CustomNavigatorHomePage extends StatefulWidget {
  CustomNavigatorHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CustomNavigatorHomePageState createState() =>
      _CustomNavigatorHomePageState();
}

class _CustomNavigatorHomePageState extends State<CustomNavigatorHomePage> {
  final List<Widget> _children = [
    MovieHome(),
    SearchHome(),
    Favorites(),
  ];
  Widget _page = MovieHome();
  int _currentIndex = 0;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        onTap: (index) {
          navigatorKey.currentState!.maybePop();
          setState(() => _page = _children[index]);
          _currentIndex = index;
        },
        currentIndex: _currentIndex,
      ),
      body: CustomNavigator(
        navigatorKey: navigatorKey,
        home: _page,
        pageRoute: PageRoutes.materialPageRoute,
      ),
    );
  }

  final _items = [
    BottomNavigationBarItem(
      icon: new Icon(Icons.home),
      label: Screen1,
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.search),
      label: Screen2,
    ),
    BottomNavigationBarItem(
      icon: new Icon(Icons.favorite),
      label: Screen3,
    ),
  ];
}

// class Page2 extends StatelessWidget {
//   const Page2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(title: Text("Page 2"), actions: <Widget>[
//               IconButton(
//                   icon: Icon(Icons.ac_unit),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         new MaterialPageRoute(
//                             builder: (BuildContext context) => new Page2()));
//                   })
//             ]),
//             body: Align(
//                 alignment: Alignment.center,
//                 child: FlatButton(
//                     color: Colors.blue,
//                     textColor: Colors.white,
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           new MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   new ListViewPage()));
//                     },
//                     child: Text("Switch Page - Leave a Like")))));
//   }
// }

// class Page3 extends StatelessWidget {
//   const Page3({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(title: Text("Page 3"), actions: <Widget>[
//               IconButton(
//                   icon: Icon(Icons.ac_unit),
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         new MaterialPageRoute(
//                             builder: (BuildContext context) => new Page2()));
//                   })
//             ]),
//             body: Align(
//                 alignment: Alignment.center,
//                 child: FlatButton(
//                     color: Colors.blue,
//                     textColor: Colors.white,
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           new MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   new ListViewPage()));
//                     },
//                     child: Text("Switch Page - Comment")))));
//   }
// }

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Infinite List"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              leading: Text("$index"), title: Text("Number $index"));
        },
      ),
    );
  }
}
