import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iot_mukrata_project/views/about_ui.dart';
import 'package:iot_mukrata_project/views/cal_bill_ui.dart';
import 'package:iot_mukrata_project/views/menu_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  //ตัวควบคุมการเปลี่ยนหน้า item ของ AnimatedNotchBottomBar
  final itemCtrl = NotchBottomBarController(index: 1);

  //สร้างตัวแปรเก็บ UI ที่จะแสดงส่งล้อกับ item ของ AnimatedNotchBottomBar ที่เลือก
  List<Widget> itemUIShow = [
    CalBillUi(),
    MenuUI(),
    AboutUi(),
  ];

//สร้างตัวแปรเก็บ index ของ item ที่เลือก
  int selectIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'Tech SAU BUFFET',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: AnimatedNotchBottomBar(
        onTap: (valueParam) {
          setState(() {
            selectIndex = valueParam;
          });
        },
        notchBottomBarController: itemCtrl,
        color: Colors.deepOrange,
        notchColor: Colors.deepOrange,
        kIconSize: 24.0,
        kBottomRadius: 28.0,
        bottomBarItems: [
          BottomBarItem(
            itemLabel: 'คิดเงิน',
            activeItem: Icon(
              FontAwesomeIcons.moneyBill1Wave,
              color: Colors.white,
            ),
            inActiveItem: Icon(
              FontAwesomeIcons.moneyBill1Wave,
              color: Colors.grey[400],
            ),
          ),
          BottomBarItem(
            itemLabel: 'หน้าหลัก',
            activeItem: Icon(
              Icons.home,
              color: Colors.white,
            ),
            inActiveItem: Icon(
              Icons.home,
              color: Colors.grey[400],
            ),
          ),
          BottomBarItem(
            itemLabel: 'เกี่ยวกับ',
            activeItem: Icon(
              FontAwesomeIcons.star,
              color: Colors.white,
            ),
            inActiveItem: Icon(
              FontAwesomeIcons.star,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
      body: itemUIShow[selectIndex],
    );
  }
}
