import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';
import 'package:intl/intl.dart';

class AddMemoryPage extends StatelessWidget {
  AppController controller = AppController();
  DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
  DateFormat dayFormat = DateFormat('E');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onPressed: () {},
                )
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
                  controller.imgUrl[Get.arguments],
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
                Expanded(
                  child: SingleChildScrollView(
                    child: TextField(
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
}
