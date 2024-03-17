import 'package:cloud_firestore/cloud_firestore.dart';
import '../User.dart';

class FirebaseHelper {
  static Future<UserModelCht?> getUserModelById(String uid) async {
    UserModelCht? userModel;

    DocumentSnapshot docSnap =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnap.data() != null) {
      userModel = UserModelCht.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return userModel;
  }
}
