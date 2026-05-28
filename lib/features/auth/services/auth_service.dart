import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn =
      GoogleSignIn.instance;

  final FirebaseFirestore firestore =
    FirebaseFirestore.instance;

  static const webClientId = "291698977867-8b859ltnjcqebk3k4c5dd0mbpsfedbdk.apps.googleusercontent.com";

  Future<User?> signInGoogle() async {
    try {

      await googleSignIn.initialize(
        serverClientId: webClientId,
      );

      final googleUser =
          await googleSignIn.authenticate();

      final googleAuth =
          googleUser.authentication;

      final credential =
          GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final result =
          await _auth.signInWithCredential(
        credential,
      );

      final user = result.user;

      if (user != null) {

        final userData =
            UserModel(
          uid: user.uid,
          name: user.displayName ?? "",
          email: user.email ?? "",
          photoUrl:
              user.photoURL ?? "",
        );

        await firestore
            .collection("users")
            .doc(user.uid)
            .set(
              userData.toMap(),
              SetOptions(
                merge: true,
              ),
            );
      }

      return user;

    } catch (e) {

      print(e);

      return null;
    }
  }

  Future<void> logout() async {
    await googleSignIn.signOut();

    await _auth.signOut();
  }
}