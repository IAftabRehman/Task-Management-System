import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/createTaskModel.dart';

class AdminServices{

  //
  Future<String?> getUserRoleByEmail(String email) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("registrationCollection")
        .where("email", isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var doc = querySnapshot.docs.first;
      return doc["userRole"];
    } else {
      return null;
    }
  }


  // Create Task
  Future<void> createTask(CreateTaskModel model) async {
    return await FirebaseFirestore.instance.collection("createTaskCollection")
        .doc(model.taskId)
        .set(model.toJson(model.taskId.toString()));
  }
}