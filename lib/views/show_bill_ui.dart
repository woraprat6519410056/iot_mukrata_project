import 'dart:io';

import 'package:flutter/material.dart';

class ShowBillUi extends StatefulWidget {
  //สร้างตัวแปรเพื่อรับข้อมูลที่จะส่งมาจากหน้า CalBillUI()
  int? numAdult;
  int? numChild;
  int? numCoke;
  int? numPure;
  double? payWaterBuffet;
  double? payBuffetTotalNoSale;
  double? paySale;
  double? payBuffetTotal;
  File? imageFile;

  //เอาตัวแปลทีที่ารา้งไปรับข้อมูลที่ส่งมา
  ShowBillUi({
    super.key,
    this.numAdult,
    this.numChild,
    this.numCoke,
    this.numPure,
    this.payWaterBuffet,
    this.payBuffetTotalNoSale,
    this.paySale,
    this.payBuffetTotal,
    required Type imageFile,
  });

  get numCild => null;

  @override
  State<ShowBillUi> createState() => _ShowBillUiState();
}

class _ShowBillUiState extends State<ShowBillUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'ใบเสร็จรับเงิน',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              widget.imageFile == null
                  ? Image.asset(
                      'assets/images/camera.jpg',
                      width: 140,
                      height: 140,
                    )
                  : Image.file(
                      widget.imageFile!,
                      width: 200,
                      height: 200,
                    ),
              SizedBox(
                height: 40,
              ),
              Text(
                'รายละเอียดใบเสร็จรับเงิน',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'จำนวนผู้ใหญ่ ${widget.numAdult} คน',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'จำนวนผู้เด็ก ${widget.numChild} คน',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'จำนวนโค้ก ${widget.numCoke} ขวด',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'จำนวนน้ำเปล่า ${widget.numPure} ขวด',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'จำนวนเงินบุฟเฟต์น้ำ ${widget.payWaterBuffet} บาท',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'ส่วนลดเป็นเงิน ${widget.paySale} บาท',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'รวมต้องจ่าย ${widget.payBuffetTotal} บาท',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/payqr.png',
                width: 250,
                height: 250,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
