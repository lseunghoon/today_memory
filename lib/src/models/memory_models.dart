import 'package:cloud_firestore/cloud_firestore.dart';

class MemoryModel {
  final String oneSentence;
  final String descText;
  final int uploadingTime;
  final int imgIndex;

  MemoryModel(
      this.oneSentence, this.descText, this.uploadingTime, this.imgIndex);

  final f = FirebaseFirestore.instance;
}
