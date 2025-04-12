import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_system/models/registrationModel.dart';

class RegistrationServices {
  Future createUser(RegistrationModel model) async {
    return await FirebaseFirestore.instance
        .collection("registrationCollection")
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  Future<List<String>> getAllUserNames() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("registrationCollection")
          .get();

      List<String> userNames = snapshot.docs
          .map((doc) => doc['name'].toString())
          .toList();

      return userNames;
    } catch (e) {
      print("Error fetching user names: $e");
      return [];
    }
  }
}
