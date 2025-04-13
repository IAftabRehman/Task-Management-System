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
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("registrationCollection")
          .where("userRole", isEqualTo: "Student/User")
          .get();
      List<String> userNames = snapshot.docs
          .map((doc) => doc['name'].toString())
          .toList();
      return userNames;
  }

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
}
