import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_system/models/createTaskModel.dart';

class CreateTaskServices {
  // Create Task
  Future<void> createTask(CreateTaskModel model) async {
    return await FirebaseFirestore.instance.collection("createTaskCollection")
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }
}