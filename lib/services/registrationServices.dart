import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management_system/models/registrationModel.dart';

class RegistrationServices {
  Future createUser(RegistrationModel model) async {
    return await FirebaseFirestore.instance
        .collection("registrationCollection")
        .doc(model.docId)
        .set(model.toJson(model.docId.toString()));
  }

  Future<RegistrationModel?> getUserName(String docId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("registrationCollection")
        .doc(docId)
        .get();

    return doc['name'];
  }

}
