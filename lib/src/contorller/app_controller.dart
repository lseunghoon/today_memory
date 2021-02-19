import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxService {
  static AppController get to => Get.find();
  RxList<String> category =
      ['영화', '독서', '여행', '육아', '운동', '음식', '데이트', '쇼핑', '업무'].obs;
  RxList<String> imgUrl = [
    'assets/images/1.png',
    'assets/images/2.png',
    'assets/images/3.png',
    'assets/images/4.png',
    'assets/images/5.png',
    'assets/images/6.png',
    'assets/images/7.png',
    'assets/images/8.png',
    'assets/images/9.png',
  ].obs;
}
