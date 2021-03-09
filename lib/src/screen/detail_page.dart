import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';

class DetailPage extends GetView<AppController> {
  DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
  DateFormat dayFormat = DateFormat('E');
  final f = FirebaseFirestore.instance;

  final item = Get.arguments;

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
          actions: [
            IconButton(
                icon: Icon(
                  Icons.share_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  share(context, item);
                }),
            IconButton(
                icon: Icon(
                  Icons.edit_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  Get.toNamed('/edit', arguments: item);
                })
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: StreamBuilder(
              stream: f.collection('data').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                    Text(
                      item['one_sentence'],
                      style: TextStyle(fontSize: 17),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Container(
                        height: 1,
                        color: Colors.black45,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: Text(
                            item['desc_text'],
                            style: TextStyle(fontSize: 15),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }

  share(BuildContext context, item) {
    final String desc = '${item['desc_text']}';

    Share.share(desc);
  }
}
