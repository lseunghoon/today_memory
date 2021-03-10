import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxService {
  final DeviceInfoPlugin plugin = DeviceInfoPlugin();
  final f = FirebaseFirestore.instance;

  static AppController get to => Get.find();
  RxString deviceId = 'qwer'.obs;
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

  indexNum(index) {
    return imgUrl[index];
  }

  final oneTextEditingController =
      TextEditingController(); //컨트롤러 만들어서 텍스트 필드 값 컨트롤.
  final descTextEditingController = TextEditingController();

  @override
  void onClose() {
    oneTextEditingController.dispose();
    descTextEditingController.dispose();
    super.onClose();
  }

  Future<void> initPlatform() async {
    if (Platform.isAndroid) {
      String data = getAndroidDevice(await plugin.androidInfo);
      deviceId(data);
    }
  }

  getAndroidDevice(AndroidDeviceInfo device) {
    return device.androidId;
  }

  @override
  void onInit() {
    initPlatform();
    super.onInit();
  }
}
