import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Provider/ProfileProvider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return Text('Counter: ${profileProvider.counter}');
            },
          ),
          ElevatedButton(
            child: Text('Increment'),
            onPressed: () =>
                Provider.of<ProfileProvider>(context, listen: false)
                    .increment(),
          ),
          ElevatedButton(
            child: Text('Go to Profile Screen'),
            onPressed: () {
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
    );
  }
}
