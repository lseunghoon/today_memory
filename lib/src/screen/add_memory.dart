import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';
import 'package:intl/intl.dart';
import 'dart:io';

import 'package:todays_memory/src/screen/memory_list.dart';

class AddMemoryPage extends StatefulWidget {
  @override
  _AddMemoryPageState createState() => _AddMemoryPageState();
}

class _AddMemoryPageState extends State<AddMemoryPage> {
  MemoryListPage memoryListPage = MemoryListPage();
  AppController controller = AppController();

  DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');

  DateFormat dayFormat = DateFormat('E');

  final imgIndex = Get.arguments;

  final f = FirebaseFirestore.instance;

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
              Get.back();
            },
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.only(
                //키보드 올라오면 바텀앱바 위로
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () {
                    if (controller.oneTextEditingController.text == '') {
                      Get.snackbar('잠시만요 저기요', '오늘의 한줄을 써주세요!');
                    } else {
                      addText();
                      Get.offAndToNamed('/list', arguments: imgIndex);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Image.asset(
                  controller.imgUrl[imgIndex],
                  width: 50,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  dateFormat.format(DateTime.now()),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  dayFormat.format(DateTime.now()),
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
            ),
          ),
        ));
  }

  addText() {
    f.collection('data').add({
      'one_sentence': '${controller.oneTextEditingController.text}',
      'desc_text': '${controller.descTextEditingController.text}',
      'time': Timestamp.now(),
      'index': imgIndex
    });
  }
}
