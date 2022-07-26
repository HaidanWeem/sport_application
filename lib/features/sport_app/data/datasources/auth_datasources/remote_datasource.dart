import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_app/core/error/auth_error/auth_failure.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';

abstract class FireBaseAuthDataSource {
  Future<MainUser> joinToAccount(String email, String password);

  Future<MainUser> signUpAccount(String email, String password, String name,
      double age, double weight, bool isMale);

  Future<void> signOut();

  Stream<MainUser?> get currentUser;

  Future<String?> retrieveUserName(MainUser user);
}

class FireBaseAuthDataSourceImpl implements FireBaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;

  @override
  Future<MainUser> joinToAccount(String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      if (result.user!.uid.isNotEmpty && result.user!.email!.isNotEmpty) {
        return MainUser.fromFireBase(result.user!);
      } else {
        throw AuthServerFailure.printMessageFromServer('id or email is null');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthServerFailure.printMessageFromServer(
          '${e.message} Failed with error code: ${e.code}');
    }
  }

  @override
  Future<MainUser> signUpAccount(String email, String password, String name,
      double age, double weight, bool isMale) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (result.user!.uid.isNotEmpty && result.user!.email!.isNotEmpty) {
        _firestoreSavingPersonalData(
            email: email, name: name, age: age, weight: weight, isMale: isMale);
        return MainUser.fromFireBase(result.user!);
      } else {
        throw AuthServerFailure.printMessageFromServer('id or email is null');
      }
    } on FirebaseAuthException catch (e) {
      throw AuthServerFailure.printMessageFromServer(
          '${e.message} Failed with error code: ${e.code}');
    }
  }

  Future<void> _firestoreSavingPersonalData({
    required String email,
    required String name,
    required double age,
    required double weight,
    required bool isMale,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    await db.collection('users').doc(user!.uid).set(
      {
        'Name': name,
        'Email': email,
        'Age': age,
        'Weight': weight,
        'IsMale': isMale,
      },
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Stream<MainUser?> get currentUser {
    return _firebaseAuth.authStateChanges().map((user) =>
        user != null ? MainUser.fromFireBase(user) : MainUser(uid: 'uid'));
  }

  @override
  Future<String?> retrieveUserName(MainUser user) async {
    return await _firebaseAuth.currentUser?.displayName;
  }
}
