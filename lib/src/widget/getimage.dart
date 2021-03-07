import 'package:flutter/material.dart';
import 'package:todays_memory/src/widget/loadimage.dart';

Future<Widget> getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(
      value.toString(),
      fit: BoxFit.scaleDown,
    );
  });
  return image;
}
