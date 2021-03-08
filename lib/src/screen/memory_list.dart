import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todays_memory/src/contorller/app_controller.dart';
import 'package:todays_memory/src/widget/getimage.dart';

final storage = FirebaseStorage.instance;

class MemoryListPage extends GetView<AppController> {
  final f = FirebaseFirestore.instance;
  DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일');
  final imgIndex = Get.arguments;

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
              Get.offAllNamed('/');
            }),
        backgroundColor: Colors.grey[50],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: f
              .collection('data')
              .orderBy('time', descending: true) //시간 순 정렬.
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              print('nnnnn');
              return CircularProgressIndicator();
            } else {
              print('yyyyy');
              final items = snapshot.data.docs;
              print(items.length);
              return items.length == 0
                  ? Center(
                      child: Text(
                        '',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          onTap: () {
                            Get.toNamed('/detail', arguments: item);
                          },
                          title: Text(
                            item['one_sentence'],
                          ),
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
                              f.collection('data').doc(docId).delete();
                            },
                          ),
                          //firebase Storage 이미지 가져오기
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: FutureBuilder(
                                future: getImage(
                                    context, '${item['index'] + 1}.png'),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          child: snapshot.data,
                                        ),
                                      ],
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: 20,
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Container();
                                }),
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
