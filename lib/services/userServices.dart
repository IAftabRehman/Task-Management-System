import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management_system/models/updationTaskModel.dart';
import 'package:task_management_system/models/userModel.dart';

class UserServices {
  Future<List<String>> getTaskFromAdminSide() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection("createTaskCollection")
            .where("userName", isEqualTo: "userName")
            .get();
    List<String> TaskData =
        snapshot.docs
            .map((doc) => doc['description']["startDate"]["endDate"].toString())
            .toList();
    return TaskData;
  }

  // Get All Data
  Future<List<Map<String, dynamic>>> getAllData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection("createTaskCollection")
            .get();

    List<Map<String, dynamic>> taskData =
        snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['docId'] = doc.id;
          return data;
        }).toList();

    return taskData;
  }

  // Update Task
  // currentUserName
  Future<String?> currentUserName(String id) async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection("registrationCollection")
            .where("docId", isEqualTo: id)
            .get();

    if (snapshot.docs.isNotEmpty) {
      var doc = snapshot.docs.first;
      return doc["email"];
    } else {
      return null;
    }
  }

  // GetData
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<List<Map<String, dynamic>>> getTasksByUsername() async {
    try {
      final username = _auth.currentUser?.displayName;
      if (username == null) return [];

      final snapshot =
          await _firestore
              .collection('tasks')
              .where('userName', isEqualTo: username)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['docId'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  // ------------------------------------------------------------------------------
  Future<void> setApplyLeaveDataIntoFirebase(UserModel model) async {
    return await FirebaseFirestore.instance
        .collection("applyLeaveCollection")
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }


  // Update Task (Status Action Button)
  Future<void> updationStatuData(UpdationTaskModel model) async {
    return await FirebaseFirestore.instance
        .collection("updationTaskCollection")
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }
}
