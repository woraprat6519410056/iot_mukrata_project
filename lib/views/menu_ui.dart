import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuUI extends StatefulWidget {
  const MenuUI({super.key});

  @override
  State<MenuUI> createState() => _MenuUIState();
}

class _MenuUIState extends State<MenuUI> {
  //สร้างตัวแปรเก็บรูปที่จะไปแสดงที่ ListView เมนูหมูกระทะ
  List<String> menuList = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png',
    'assets/images/img4.png',
    'assets/images/img5.png',
    'assets/images/img6.png',
    'assets/images/img7.png',
  ];

  //สร้างตัวแปรเก็บรูปที่จะไปแสดงที่ ListView สาขาร้านหมูกระทะ
  List<String> branchList = [
    'assets/images/shop1.png',
    'assets/images/shop2.png',
    'assets/images/shop3.png',
    'assets/images/shop4.png',
    'assets/images/shop5.png',
  ];
  //สร้างตัวแปรเก็บเบอร์โทร
  List<String> phoneList = [
    '081-000-0000',
    '082-000-0000',
    '083-000-0000',
    '084-000-0000',
    '085-000-0000',
  ];

  //เมทธอทโทร
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            Image.asset(
              'assets/images/logo.png',
              width: 150.0,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'เมนูเด็ด',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 100.0,
              margin: EdgeInsets.only(
                left: 25.0,
                right: 25.0,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        menuList[index],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'ร้านในเครือ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: branchList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20.0,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: InkWell(
                          onTap: () {
                            _makePhoneCall(phoneList[index]);
                          },
                          child: Image.asset(
                            branchList[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
