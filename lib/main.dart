import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';
import 'package:todays_memory/src/screen/add_memory.dart';
import 'package:todays_memory/src/screen/home_page.dart';
import 'package:todays_memory/src/screen/memory_list.dart';

AppController controller = AppController();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        accentColor: Colors.transparent, //드래그 시 컬러 투명하게.
        fontFamily: 'NanumMyeongjo',
        cursorColor: Colors.black,
      ),
      initialRoute: '/',
      initialBinding: BindingsBuilder(() {
        Get.put(AppController());
      }),
      getPages: [
        GetPage(name: '/', page: () => HomePage()),
        GetPage(
          name: '/add',
          page: () => AddMemoryPage(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
        GetPage(
          name: '/list',
          page: () => MemoryListPage(),
          transition: Transition.leftToRightWithFade,
          transitionDuration: Duration(milliseconds: 500),
        ),
      ],
    );
  }
}
