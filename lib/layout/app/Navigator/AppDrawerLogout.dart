import 'package:flutter/material.dart';


import '../../authen/Authen.layout.dart';
import 'AppDrawerItem.dart';

class AppDrawerLogout extends AppDrawerItem {
  AppDrawerLogout(
      {super.key,
      title = "Logout",
      required super.route,
      icon = Icons.lock,
      onTap})
      : super(title: 'Logout', icon: Icons.lock, onTap: () {});

  _showDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:  const Row(children: [Icon(Icons.lock ,size: 48,),Text('Logout App')],) ,

          content: const Text('Do you want to logout the app?'),
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
                //Navigator.of(context).pop();
                Navigator.pop(context);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => AuthenLayout())
                  );
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
