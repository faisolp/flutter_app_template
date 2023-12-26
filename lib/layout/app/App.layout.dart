import 'package:flutter/material.dart';
import 'package:flutter_apptemplate/layout/app/Navigator/AppDrawerLogout.dart';

import 'package:provider/provider.dart';

import '../../Provider/ProfileProvider.dart';
import 'Navigator/AppDrawerHeader.dart';
//Applications 'Navigator/AppDrawerItem.dart';
import 'Navigator/AppDrawerItems.dart';

import 'Navigator/AppDrawerExit.dart';
import 'view/HomeScreen.dart';
import 'view/ProfileScreen.dart';

class App extends StatelessWidget {
  final String AppTitle = 'Template App';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MaterialApp(
        title: AppTitle,
        home:  MyHomePage(
          title: AppTitle,
        ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});
  //MyHomePageState createState() => _MyHomePageState();
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String _selectedRoute = '/home';
  void _navigateTo(String routeName) {
    setState(() {
      _selectedRoute = routeName; // อัปเดต route ที่เลือก
    });
    _navigatorKey.currentState!
        .pushNamedAndRemoveUntil(routeName, (route) => false);
  }

  final List<Map<String, String>> routes = [
    {'route': '/home', 'title': 'Home', 'icon': 'home'},
    {'route': '/profile', 'title': 'Profile', 'icon': 'person'},
    // เพิ่ม routes อื่นๆ ที่นี่
  ];
  Route<dynamic> _generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case '/':
        builder = (BuildContext _) => HomeScreen();
        break;
      case '/profile':
        builder = (BuildContext _) => ProfileScreen();
        break;
      default:
        builder = (BuildContext _) => HomeScreen(); // Default to HomeScreen
        break;
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            AppDrawerHeader(title: "Manu"),
            AppDrawerItems(
              routes: routes,
              selectedRoute: _selectedRoute,
              onItemTap: (route) {
                Navigator.of(context).pop(); // Close the drawer
                _navigateTo(route);
              },
            ),
            AppDrawerLogout(
              title: "Logout",
              icon: Icons.lock,
              route: "./logout",
            ),
            AppDrawerExit(
              title: "Exit",
              icon: Icons.exit_to_app,
              route: "./exit",
            ),
          ],
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: _generateRoute,
      ),
    );
  }
}
