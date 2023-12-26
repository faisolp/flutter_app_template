import 'package:flutter/material.dart';

import 'Component/SelectDropList/SelectDropList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget itemBuilder(OptionItem item) {
    return Text(
      item.title,
      style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w400,
          fontSize: 14),
      maxLines: 3,
      textAlign: TextAlign.start,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    // สร้างข้อมูลตัวอย่าง
    var dropListModel = DropListModel([
      OptionItem(id: '1', title: 'Option 1'),
      OptionItem(id: '2', title: 'Option 2'),
      OptionItem(id: '3', title: 'Option 3'),
    ]);

    OptionItem? itemSelected; //= dropListModel.listOptionItems[0];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: SelectDropList(
              itemSelected: itemSelected,
              dropListModel: dropListModel,
              onOptionSelected: (OptionItem item) {
                // การดำเนินการเมื่อมีการเลือก OptionItem
                print('Selected Item: ${item.title}');
              },
              itemBuilder: itemBuilder),
        ));
  }
}



// แอปหลัก


// คลาส DropListModel ที่เก็บรายการของ OptionItem
