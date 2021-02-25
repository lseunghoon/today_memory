import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';

class MemoryListPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    height: 100,
                    child: ListTile(
                      title: Text(controller.category[index]),
                      subtitle: Text(index.toString()),
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            controller.imgUrl[index],
                            width: 20,
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
                childCount: controller.category.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
