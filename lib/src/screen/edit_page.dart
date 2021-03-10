import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todays_memory/main.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';

class EditPage extends GetView<AppController> {
  DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
  DateFormat dayFormat = DateFormat('E');
  final f = FirebaseFirestore.instance;

  final item = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              '수정',
              style: TextStyle(color: Colors.black),
            ),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // IconButton(
                  //   icon: Icon(Icons.image),
                  //   onPressed: () {},
                  // ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      if (controller.oneTextEditingController.text == '') {
                        Get.snackbar('잠시만요 저기요', '오늘의 한줄을 써주세요!');
                      } else {
                        setText();
                        Get.offAndToNamed('/list');
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
              child: StreamBuilder(
                stream: f.collection('data').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        dayFormat.format(
                          DateTime.parse(item['time'].toDate().toString()),
                        ),
                        style: TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: controller.oneTextEditingController
                          ..text = '${item['one_sentence']}',
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
                          child: TextFormField(
                            controller: controller.descTextEditingController
                              ..text = '${item['desc_text']}',
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
          )),
    );
  }

  //수정하는 기능, id 빼내기 힘듬..
  setText() {
    f.collection(controller.deviceId.value).doc(item.id).update({
      'one_sentence': '${controller.oneTextEditingController.text}',
      'desc_text': '${controller.descTextEditingController.text}',
    });
  }
}
