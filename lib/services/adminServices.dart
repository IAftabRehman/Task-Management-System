import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/createTaskModel.dart';

class AdminServices {

  // Get User through by Email
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

  // For Creating Task (Get User Name [show in the fields])
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

  // 2. Get Update or Reedit
  Future<void> updateTaskById(
    String docId,
    Map<String, dynamic> updatedData,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection("createTaskCollection")
          .doc(docId)
          .update(updatedData);
    } catch (e) {
      print("Error updating task: $e");
      rethrow;
    }
  }

  // Current Email (for LogOut)
  Future<String?> currentEmail(String id) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
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
}
