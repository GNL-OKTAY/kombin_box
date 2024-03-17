import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import '../models/user.dart' as model;
import '../resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get user details
  Future<model.UserModel> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.UserModel.fromSnap(documentSnapshot);
  }

  //singup user
  Future<String> singUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "some error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        //print(cred.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePic', file, false);

        model.UserModel user = model.UserModel(
          username: username,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          photoUrl: photoUrl,
          following: [],
          followers: [],
        );

        //  add user to our database
        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        //
        //await _firestore.collection('users').add({
        //  'username': username,
        //  'uid': cred.user!.uid,
        //  'email': email,
        //  'bio': bio,
        //  'followers': [],
        //  'following': [],
        //});
        res = "success";
      } else {
        res = 'lütfen tüm alanları doldurun !';
      }
    }
    //on FirebaseAuthException catch (err) {
    //  if (err.code == 'invalid-email') {
    //    res = 'The email is body formatted.';
    //  } else if (err.code == 'week-password') {
    //    res = 'Password shold be at least 6 characters';
    //  }
    //}
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  // login in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "some error accurred";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "lütfen tüm alanları doldurun";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {}
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
