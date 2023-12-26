import 'package:flutter/material.dart';

class AppDrawerHeader extends StatelessWidget {
  final String title;

  AppDrawerHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 24,
        ),
      ),
      const Text("Username") ],
      )
    );
  }
}
