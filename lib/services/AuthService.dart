// Class will handle functionalities related to Firebase
// Authentication

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_online_store_1/services/DatabaseService.dart';

class AuthService {
  // Instance to access the Firebase API
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Login function
  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
  Future registerUser(String firstName, String lastName, String email, String password) async {
    try {
      // Old code
      // AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      // Save user data on firestore
      await DatabaseService(uid: result.user.uid).addUserData(email, firstName, lastName);

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
      User user = _auth.currentUser;
      return user;
    } catch (e) {
      return null;
    }
  }
}