import 'package:flutter/material.dart';

class AppDrawerItem extends StatelessWidget {

  final String title;
  final String route;
  final IconData icon;
  final VoidCallback onTap;
  final bool selected; // เพิ่มตัวแปร selected

  AppDrawerItem(
      {super.key,  
        
      required this.title,
      required this.route,
      required this.icon,
      required this.onTap,
      this.selected = false
      });
  @override
  Widget build(BuildContext context) {
    //bool isSelected = ModalRoute.of(context)?.settings.name == route;
    return ListTile(
      
      leading: Icon(icon),
      title: Text(title),
      selected: selected, // ใช้ตัวแปร selected
      selectedTileColor: Theme.of(context).highlightColor, // สี Highlight สำหรับรายการที่เลือก
      onTap: onTap,
    );
  }
}