import 'package:flutter/material.dart';

class DropListModel {
  DropListModel(this.listOptionItems);
  final List<OptionItem> listOptionItems;
}

// คลาส OptionItem ที่แสดงข้อมูลแต่ละตัวเลือก
class OptionItem {
  final String id;
  final String title;
  OptionItem({required this.id, required this.title});
}

// วิดเจ็ต SelectDropList ที่แสดง Dropdown
class SelectDropList extends StatefulWidget {
  final OptionItem? itemSelected;
  final String? labelText;
  final DropListModel dropListModel;
  final Function(OptionItem optionItem) onOptionSelected;
  final IconData? leftIcon; // เพิ่มตัวเลือกสำหรับ Icon
  final Widget Function(OptionItem item)? itemBuilder; // ทำให้ itemBuilder เป็น optional

  SelectDropList({
    this.itemSelected,
    required this.dropListModel,
    required this.onOptionSelected,
    this.itemBuilder, // รับ callback function
    this.leftIcon,
    this.labelText
  }); // เพิ่มพารามิเตอร์ leftIcon

  @override
  _SelectDropListState createState() =>
      _SelectDropListState(itemSelected, dropListModel);
}

// State ของ SelectDropList
class _SelectDropListState extends State<SelectDropList>
    with SingleTickerProviderStateMixin {
  OptionItem? optionItemSelected; // ทำให้ optionItemSelected เป็น optional
  final DropListModel dropListModel;

  late AnimationController expandController;
  late Animation<double> animation;
  bool isShow = false;

  _SelectDropListState(this.optionItemSelected, this.dropListModel);

  @override
  void initState() {
    super.initState();
    optionItemSelected = widget.itemSelected; // กำหนดค่าเริ่มต้นจาก widget
    expandController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 350));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if (isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // รูปแบบของ Container หลัก
      child: Column(
        children: [
          _buildDropdownButton(context),
          _buildDropdownOptions(),
        ],
      ),
    );
  }

  // สร้างปุ่ม Dropdown
  Widget _buildDropdownButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black26, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget.leftIcon != null
              ? Icon(widget.leftIcon, color:Theme.of(context).colorScheme.primary) // :Color(0xFF307DF1))
              : SizedBox(width: 10), // ใช้ leftIcon ถ้ามีการกำหนด
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  this.isShow = !this.isShow;
                  _runExpandCheck();
                });
              },
              child: Text(
                optionItemSelected?.title ??
                   widget.labelText?? 'เลือกรายการ', // แสดงข้อความ "เลือกรายการ" ถ้ายังไม่มีการเลือก
                style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Icon(
              isShow ? Icons.arrow_drop_down : Icons.arrow_right,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // สร้างตัวเลือก Dropdown
  Widget _buildDropdownOptions() {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 4, color: Colors.black26, offset: Offset(0, 4))
          ],
        ),
        child: _buildDropListOptions(dropListModel.listOptionItems, context),
      ),
    );
  }

  // สร้างรายการตัวเลือก
  Column _buildDropListOptions(List<OptionItem> items, BuildContext context) {
    return Column(
      children: items.map((item) => _buildDropListItem(item, context)).toList(),
    );
  }

  // สร้างแต่ละตัวเลือก
  Widget _buildDropListItem(OptionItem item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 26.0, top: 5, bottom: 5),
      child: GestureDetector(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey.shade200, width: 1)),
                ),
                child: widget.itemBuilder != null
                    ? widget.itemBuilder!(item) // ใช้ itemBuilder ถ้ามีการกำหนด
                    : Text(
                        // ใช้การแสดงผลมาตรฐานถ้าไม่มีการกำหนด itemBuilder
                        item.title,
                        style: TextStyle(
                            color:Theme.of(context).colorScheme.primary, // Color(0xFF307DF1),
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        maxLines: 3,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
          ],
        ),
        onTap: () {
          setState(() {
            this.optionItemSelected = item;
            isShow = false;
            expandController.reverse();
            widget.onOptionSelected(item);
          });
        },
      ),
    );
  }
}
