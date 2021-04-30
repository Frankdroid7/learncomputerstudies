import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_computer_studies/model/user_model.dart';

class FirebaseService {
  static String _errorMsg;
  static User user = auth.currentUser;
  static String get errorMsg => _errorMsg;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  static Future<User> signIn(
      {@required String email, @required String password}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // user = userCredential.user;
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _errorMsg = 'Wrong email/password combination.';
        return null;
      } else if (e.code == 'user-not-found') {
        _errorMsg = 'No user found with this email.';
        return null;
      } else if (e.code == 'invalid-email') {
        _errorMsg = 'Email address is invalid.';
        return null;
      }
      _errorMsg = 'Something went wrong, please try again.';
      return null;
    } catch (e) {
      _errorMsg = 'Something went wrong, please try again';
      return null;
    }
  }

  static Future<User> signUp({
    @required String email,
    @required String password,
    @required String lastName,
    @required String firstName,
  }) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // user = userCredential.user;
      await FirebaseService.addUserData(UserData(
        email: email,
        lastName: lastName,
        firstName: firstName,
      )).then((value) => print('value: $value'));
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _errorMsg = 'The password provided is too weak.';
        return null;
      } else if (e.code == 'email-already-in-use') {
        _errorMsg = 'An account already exists for that email.';
        return null;
      }
      _errorMsg = 'Something went wrong, please try again.';
      return null;
    } catch (e) {
      _errorMsg = 'Something went wrong, try again';
      return null;
    }
  }

  static Future<DocumentReference> addUserData(UserData data) {
    return collectionReference.add(data.toJson());
  }

  static Future signOut() => auth.signOut();
}
