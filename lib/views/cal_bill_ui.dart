import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iot_mukrata_project/views/show_bill_ui.dart';

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

  //สร้างเมธอดแสดงข้อความเตือน
  Future<void> showWarningDialog(context, msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('คำเตือน'),
          content: Text(
            msg,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                      activeColor: Colors.deepOrange,
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
                      activeColor: Colors.deepOrange,
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
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //Validate UI
                          if (isAdult == true && adultCtrl.text.isEmpty ||
                              adultCtrl.text == '0') {
                            showWarningDialog(
                                context, 'กรุณากรอกจํานวนผู้ใหญ่ด้วย');
                          } else if (isChild == true &&
                                  childCtrl.text.isEmpty ||
                              childCtrl.text == '0') {
                            showWarningDialog(
                                context, 'กรุณากรอกจํานวนเด็กด้วย');
                          } else {
                            //คำนวนเงิน
                            //เตรียมข้อมูลที่ต้องใช้เพื่อการคำนวณ
                            int numAdult =
                                isAdult == true ? int.parse(adultCtrl.text) : 0;
                            int numChild =
                                isChild == true ? int.parse(childCtrl.text) : 0;
                            int numCoke = cokeCtrl.text.isEmpty
                                ? 0
                                : int.parse(cokeCtrl.text);
                            int numPure = pureCtrl.text.isEmpty
                                ? 0
                                : int.parse(pureCtrl.text);
                            double sale = 0.0;
                            if (_selectedMember == 'สมาชิกทั่วไปลด 10%') {
                              sale = 0.1;
                            } else if (_selectedMember == 'สมาชิก VIP ลด 20%') {
                              sale = 0.2;
                            }
                            double payWaterBuffet = groupWater == 1
                                ? 25.0 * (numAdult + numChild)
                                : 0.0;
                            //คำนวณยังไม่ได้คิดส่วนลด
                            double payBuffetTotalNoSale = (numAdult * 299.0) +
                                (numChild * 69.0) +
                                (numCoke * 20.0) +
                                (numPure * 15.0) +
                                payWaterBuffet;
                            //คำนวณส่วนลด
                            double paySale = payBuffetTotalNoSale * sale;
                            //คำนวณที่ต้องจ่ายหลังหักส่วนลดแล้ว
                            double payBuffetTotal =
                                payBuffetTotalNoSale - paySale;

                            //ส่งค่าต่างๆ ไปแสดงที่หน้า ShowBillUI()
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowBillUi(
                                  numAdult: numAdult,
                                  numChild: numChild,
                                  numCoke: numCoke,
                                  numPure: numPure,
                                  payWaterBuffet: payWaterBuffet,
                                  payBuffetTotalNoSale: payBuffetTotalNoSale,
                                  paySale: paySale,
                                  payBuffetTotal: payBuffetTotal,
                                  imageFile: File,
                                ),
                              ),
                            );
                          }
                        },
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
                          fixedSize: Size(
                            double.infinity,
                            60.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          //ทุกอย่างบนหน้าจอกลับเป็นค่าเริ่มต้นหรือเหมือนเดิม
                          setState(() {
                            imgFile = null;
                            isAdult = false;
                            isChild = false;
                            isWater = false;
                            adultCtrl.clear();
                            childCtrl.clear();
                            cokeCtrl.clear();
                            pureCtrl.clear();
                            groupWater = 1;
                            _selectedMember = 'ไม่เป็นสมาชิก';
                          });
                        },
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
                          fixedSize: Size(
                            double.infinity,
                            60.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
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
