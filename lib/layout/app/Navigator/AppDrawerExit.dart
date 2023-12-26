import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'AppDrawerItem.dart';

class AppDrawerExit extends AppDrawerItem {
  AppDrawerExit(
      {super.key,
      title = "Exit",
      required super.route,
      icon = Icons.exit_to_app,
      onTap})
      : super(title: 'Exit', icon: Icons.exit_to_app, onTap: () {});

  _showDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Row(children: [Icon(Icons.exit_to_app,size: 48,),Text('Exit App')],) ,
          content: const Text('Do you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  SystemNavigator.pop(); // Exits the app
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //bool isSelected = ModalRoute.of(context)?.settings.name == route;
    return ListTile(
        leading: Icon(icon),
        title: Text(title),
        selected: selected, // ใช้ตัวแปร selected
        selectedTileColor: Theme.of(context)
            .highlightColor, // สี Highlight สำหรับรายการที่เลือก
        onTap: () {
           
          _showDialog(context: context);
           onTap();
        });
  }
}
