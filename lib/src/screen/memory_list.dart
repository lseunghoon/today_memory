import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';
import 'package:todays_memory/src/screen/add_memory.dart';

class MemoryListPage extends GetView<AppController> {
  final f = FirebaseFirestore.instance;
  DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }),
        backgroundColor: Colors.grey[50],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: f.collection('data').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final items = snapshot.data.docs;
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      title: Text(item['one_sentence']),
                      subtitle: Text(
                        dateFormat.format(
                          DateTime.parse(item['time'].toDate().toString()),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          final docId = snapshot.data.docs[index]
                              .id; //삭제 하는부분, doc id 뽑느라 하루종일 씀.
                          print(docId);
                          f.collection('data').doc(docId).delete();
                        },
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
