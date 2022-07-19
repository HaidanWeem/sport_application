import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainUser extends Equatable {
  String? uid;
  bool? isVerified;
  String? email;
  String? password;
  String? displayName;

  MainUser(
      {this.uid, this.email, this.password, this.displayName, this.isVerified});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
    };
  }

  MainUser.fromFireBase(User user) {
    uid = user.uid;
    email = user.email;
    displayName = user.displayName;
  }

  MainUser.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uid = doc.id,
        email = doc.data()!["email"],
        displayName = doc.data()!["displayName"];

  MainUser copyWith({
    bool? isVerified,
    String? uid,
    String? email,
    String? password,
    String? displayName,
    int? age,
  }) {
    return MainUser(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        password: password ?? this.password,
        displayName: displayName ?? this.displayName,
        isVerified: isVerified ?? this.isVerified);
  }

  @override
  List<Object?> get props => [uid, email, password, displayName];
}
