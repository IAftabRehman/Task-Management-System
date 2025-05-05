import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/createTaskModel.dart';

class AdminServices {
  Future<String?> getUserRoleByEmail(String email) async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance
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

  // For Create Task (get User name)
  Future<List<String>> getAllUserNames() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance
            .collection("registrationCollection")
            .where("userRole", isEqualTo: "Student/User")
            .get();
    List<String> userNames =
        snapshot.docs.map((doc) => doc['name'].toString()).toList();
    return userNames;
  }



  // Create Task
  Future<void> createTask(CreateTaskModel model) async {
    return await FirebaseFirestore.instance
        .collection("createTaskCollection")
        .doc(model.taskId)
        .set(model.toJson(model.taskId.toString()));
  }



  // Manage Task
  // 1. Get All Data
  Future<List<Map<String, dynamic>>> getAllData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("createTaskCollection")
        .get();

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

  }




  // Delete Data
  Future<void> deleteTask() async {
    await FirebaseFirestore.instance
        .collection("createTaskCollection")
        .doc()
        .delete();
  }
}
