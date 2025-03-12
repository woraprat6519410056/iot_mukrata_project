import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CallBillUI extends StatefulWidget {
  const CallBillUI({super.key});

  @override
  State<CallBillUI> createState() => _CallBillUIState();
}

class _CallBillUIState extends State<CallBillUI> {
  //สร้างตัวแปรเก็บรูปที่ได้จากกล้อง-แกลอรี่
  File? imgFile;

  //สรัางตัวแปรเก็บสถานะเลือกผู้ใหญ่ และเด็ก
  bool? isAdult = false;
  bool? isChild = false;

  //สร้างตัวแปรเก็บสถานะใช้ได้ ใช้ไม่ได้ของป้อนโค้ก น้ำเปล่า
  bool? isWater = false;

  //สร้างตัวควบคุม TextField
  TextEditingController adultCtrl = TextEditingController();
  TextEditingController childCtrl = TextEditingController();
  TextEditingController cokeCtrl = TextEditingController();
  TextEditingController pureCtrl = TextEditingController();

  //สร้างตัวแปรสำหรับ Radio เพื่อให้อยู่กลุ่มเดียว
  int? groupWater = 1;

  //สร้างตัวแปรเก็บค่าที่เลือกจาก Dropdown
  String? _selectedMember = 'ไม่เป็นสมาชิก';

  //สร้างเมธอดเปิดกล้อง
  Future<void> openCamera() async {
    //เปิดกล้องเพื่อถ่าย
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    //ตรวจสอบว่าได้ถ่ายไหม
    if (image == null) return;
    //หากได้ถ่ายก็เอารูปที่ถ่ายไปกำหนดให้กับตัวแปรที่สร้างไว้
    setState(() {
      imgFile = File(image.path);
    });
  }

  //สร้างเมธอดเปิดแกลอรี่
  Future<void> openGallery() async {
    //เปิดแกลอรี่เพื่อเลือก
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //ตรวจสอบว่าได้เลือกไหม
    if (image == null) return;
    //หากได้เลือกก็เอารูปที่เลือกไปกำหนดให้กับตัวแปรที่สร้างไว้
    setState(() {
      imgFile = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 50.0,
            bottom: 50.0,
            left: 40.0,
            right: 40.0,
          ),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => Wrap(
                        children: [
                          ListTile(
                            onTap: () {
                              openCamera()
                                  .then((value) => {Navigator.pop(context)});
                            },
                            leading: Icon(
                              Icons.camera_alt,
                              color: Colors.deepOrange,
                            ),
                            title: Text(
                              'เปิดกล้อง',
                              style: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                          Divider(),
                          ListTile(
                            onTap: () {
                              openGallery()
                                  .then((value) => {Navigator.pop(context)});
                            },
                            leading: Icon(
                              Icons.camera,
                              color: Colors.deepOrange,
                            ),
                            title: Text(
                              'เปิดแกลอรี่',
                              style: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: imgFile == null
                      ? Image.asset(
                          'assets/images/camera.jpg',
                          width: 130.0,
                          height: 130.0,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          imgFile!,
                          width: 130.0,
                          height: 130.0,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'จำนวนคน',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (value) {
                        setState(() {
                          isAdult = value;
                          if (value == false) {
                            adultCtrl.clear();
                          }
                        });
                      },
                      value: isAdult,
                      activeColor: Colors.deepOrange,
                    ),
                    Text(
                      'ผู้ใหญ่ 299 บาท/คน จำนวน ',
                    ),
                    Expanded(
                      child: TextField(
                        controller: adultCtrl,
                        enabled: isAdult,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                        ),
                      ),
                    ),
                    Text(
                      'คน',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      onChanged: (value) {
                        setState(() {
                          isChild = value;
                          if (value == false) {
                            childCtrl.clear();
                          }
                        });
                      },
                      value: isChild,
                      activeColor: Colors.deepOrange,
                    ),
                    Text(
                      'เด็ก 69 บาท/คน จำนวน ',
                    ),
                    Expanded(
                      child: TextField(
                        controller: childCtrl,
                        enabled: isChild,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                        ),
                      ),
                    ),
                    Text(
                      'คน',
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'บุปเฟต์น้ำดื่ม',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: groupWater,
                      onChanged: (value) {
                        setState(() {
                          groupWater = value!;
                          isWater = false;
                          cokeCtrl.clear();
                          pureCtrl.clear();
                        });
                      },
                    ),
                    Text(
                      'รับ 25 บาท/หัว',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: groupWater,
                      onChanged: (value) {
                        setState(() {
                          groupWater = value!;
                          isWater = true;
                        });
                      },
                    ),
                    Text(
                      'ไม่รับ',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '              โค้ก 20 บาท/ขวด จำนวน ',
                    ),
                    Expanded(
                      child: TextField(
                        enabled: isWater,
                        controller: cokeCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                        ),
                      ),
                    ),
                    Text(
                      'ขวด',
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      '              น้ำเปล่า 15 บาท/ขวด จำนวน ',
                    ),
                    Expanded(
                      child: TextField(
                        enabled: isWater,
                        controller: pureCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '0',
                        ),
                      ),
                    ),
                    Text(
                      'ขวด',
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'ประเภทสมาชิก',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedMember,
                        onChanged: (value) {
                          setState(() {
                            _selectedMember = value;
                          });
                        },
                        items: <String>[
                          'ไม่เป็นสมาชิก',
                          'สมาชิกทั่วไปลด 10%',
                          'สมาชิก VIP ลด 20%'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: _selectedMember == value
                                    ? Colors.red
                                    : Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.calculate,
                          color: Colors.white,
                        ),
                        label: Text(
                          'คำนวณ',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        ),
                        label: Text(
                          'ยกเลิก',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
