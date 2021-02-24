import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todays_memory/src/component/category_icon.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';

class HomePage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          '오늘의 기억',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {}),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(
                controller.category.length,
                (index) {
                  return Container(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed('/add', arguments: index);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                controller.imgUrl[index],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Text(
                                controller.category[index],
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
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
    );
  }
}
