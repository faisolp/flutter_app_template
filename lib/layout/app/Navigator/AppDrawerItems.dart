import 'package:flutter/material.dart';

import '../../../tools/UI.tool.dart';
import 'AppDrawerItem.dart';

class AppDrawerItems extends StatelessWidget {
  final List<Map<String, String>> routes;
  final Function(String) onItemTap;
  final String selectedRoute ;

  AppDrawerItems({required this.routes, required this.onItemTap ,required this.selectedRoute});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routes.map((routeInfo) {
        return AppDrawerItem(
          title: routeInfo['title']!,
          route: routeInfo['route']!,
          icon: getIconData(routeInfo['icon']!),
          selected: selectedRoute==routeInfo['route'],
          onTap: () => onItemTap(routeInfo['route']!),
        );
      }).toList(),
    );
  }
}