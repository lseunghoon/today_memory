import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todays_memory/main.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';

class DetailPage extends GetView<AppController> {
  DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
  DateFormat dayFormat = DateFormat('E');
  final f = FirebaseFirestore.instance;

  final item = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[50],
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              print(item);
              Get.back();
            },
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.edit_rounded,
                  color: Colors.black,
                ),
                onPressed: () {})
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: StreamBuilder(
              stream: f.collection('data').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return Column(
                  children: [
                    Image.asset(
                      'assets/images/${item['index'] + 1}.png',
                      width: 50,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      dateFormat.format(
                        DateTime.parse(item['time'].toDate().toString()),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      dayFormat.format(
                        DateTime.parse(item['time'].toDate().toString()),
                      ),
                      style: TextStyle(color: Colors.black),
                    ),
                    TextField(
                      controller: controller.oneTextEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: '오늘의 기억 한줄 요약',
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 1,
                        color: Colors.black45,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: TextField(
                          controller: controller.descTextEditingController,
                          maxLines: 99,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: '오늘의 기억을 남겨보세요',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}
