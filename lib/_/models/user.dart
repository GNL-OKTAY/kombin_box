import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String username;
  final String email;
  final String uid;
  final String bio;
  final List followers;
  final List following;
  final String photoUrl;

  const UserModel({
    required this.email,
    required this.uid,
    required this.photoUrl,
    required this.bio,
    required this.followers,
    required this.following,
    required this.username,
  });

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserModel(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
      photoUrl: snapshot["photoUrl"],
      bio: snapshot["bio"],
      followers: snapshot["followers"],
      following: snapshot["following"],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'bio': bio,
        'followers': followers,
        'following': following,
        'photoUrl': photoUrl,
      };
}

// kopyaladım ve koydum sonrasında modif yapılıp usermodelcht kısmı kaldırılmalı

class UserModelCht {
  String? uid;
  String? fullname;
  String? email;
  String? profilepic;
  String? bio;
  List? followers;
  List? following;

  UserModelCht(
      {this.uid,
      this.fullname,
      this.email,
      this.profilepic,
      this.bio,
      this.followers,
      this.following});

  UserModelCht.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["username"];
    email = map["email"];
    profilepic = map["photoUrl"];
    bio = map["bio"];
    followers = map["followers"];
    following = map["following"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": fullname,
      "email": email,
      "photoUrl": profilepic,
      'bio': bio,
      'followers': followers,
      'following': following,
    };
  }
}
