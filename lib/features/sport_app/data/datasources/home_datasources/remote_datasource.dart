import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_app/core/error/exception.dart';
import 'package:sport_app/core/error/failure.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';
import 'package:sport_app/features/sport_app/domain/entities/user.dart';

abstract class HomeRemoteDataSource {
  Stream<MainUser> get currentUser;

  Future<CurrentUser> getUser();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Stream<MainUser> get currentUser {
    return _firebaseAuth.authStateChanges().map((user) =>
        user != null ? MainUser.fromFireBase(user) : MainUser(uid: 'uid'));
  }

  @override
  Future<CurrentUser> getUser() async {
    try {
      final user = await currentUser.first;
      DocumentReference ref = await db.collection("users").doc(user.uid);
      DocumentSnapshot snapshot = await ref.get();
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      return CurrentUser.fromJson(data);
    } on ServerException catch (e) {
      throw ServerFailure.printMessageFromServer(e.toString());
    }
  }
}
