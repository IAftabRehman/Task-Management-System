import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Future<List<String>> getTaskFromAdminSide() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("createTaskCollection")
        .where("userName", isEqualTo: "userName")
        .get();
    List<String> TaskData = snapshot.docs
        .map((doc) => doc['description']["startDate"]["endDate"].toString())
        .toList();
    return TaskData;
  }
}