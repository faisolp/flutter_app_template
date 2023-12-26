
//LoginDemo Version 1.0

import 'package:flutter/material.dart';

import 'view/LoginScreen.dart';


class AuthenLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoginDemo',
      home: LoginScreen(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
      ),
    );
  }
}



