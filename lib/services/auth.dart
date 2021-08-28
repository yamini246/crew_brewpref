import 'package:crew_brew_pref/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crew_brew_pref/models/user_data.dart';
import 'package:flutter/material.dart';
class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on FirebaseUser
  UserData? _userFromFirebaseUser(User? user) {
     return user != null ? UserData(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserData?> get user {
    return _auth.authStateChanges()
    //.map((User? user) => _userFromFirebaseUser(user!));  {can use this too instead of the next line}
    .map(_userFromFirebaseUser);
  }


  // sign in
  Future signInWithEmailAndPassword(String email, String password)  async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // register
  Future registerWithEmailAndPassword(String email, String password)  async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('0', 'new crew member', 100);
      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }


  // sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    }
    catch(e) {
      print(e.toString());
      return null;
    }
  }
}