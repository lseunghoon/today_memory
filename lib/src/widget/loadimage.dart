import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todays_memory/src/screen/memory_list.dart';

class FireStorageService extends GetxController {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await storage.ref().child(image).getDownloadURL();
  }
}
