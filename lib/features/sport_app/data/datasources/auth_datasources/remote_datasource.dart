import 'package:firebase_auth/firebase_auth.dart';
import 'package:sport_app/core/error/auth_error/auth_failure.dart';
import 'package:sport_app/features/sport_app/data/models/mainuser.dart';

abstract class FireBaseAuthDataSource {
  Future<MainUser> joinToAccount(String email, String password);

  Future<MainUser> signUpAccount(String email, String password);

  Future<void> signOut();

  Stream<MainUser?> get currentUser;

  Future<String?> retrieveUserName(MainUser user);
}

class FireBaseAuthDataSourceImpl implements FireBaseAuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<MainUser> joinToAccount(String email, String password) async {
    return await _formAuth(() {
      return _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    });
  }

  @override
  Future<MainUser> signUpAccount(String email, String password) async {
    return await _formAuth(() {
      return _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    });
  }

  Future<MainUser> _formAuth(Future<UserCredential> Function() auth) async {
    try {
      UserCredential result = await auth();
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
