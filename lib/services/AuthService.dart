// Class will handle functionalities related to Firebase
// Authentication

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Instance to access the Firebase API
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function
  Future loginUser(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      // return the user object
      print(result);
      return result.user;
    } catch (e) {
      print(e.toString());
      // null to say an error occured
      return null;
    }
  }

  // Register function
  Future registerUser(String email, String password) async {
    try {
       AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // return the user object
      print(result);
      return result.user;
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Logout
  Future logoutUser() async {
    try {
      // call the API to logout
      return await _auth.signOut();
    } catch(e) {
      return null;
    }
  }

  // Check if the user logged in previously
  Future checkIsLoggedIn() async {
    try {
      FirebaseUser user = await _auth.currentUser();
      return user;
    } catch (e) {
      return null;
    }
  }
}