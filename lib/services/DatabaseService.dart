// Service that is responsible for all of the 
// Firestore functionalities
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  // Collection reference for the user
  CollectionReference userRef = Firestore.instance.collection("users");

  // Collection reference for the product
  CollectionReference itemRef = Firestore.instance.collection("product");

  // Collection reference for the cart
  CollectionReference cartRef = Firestore.instance.collection("cart");
  
  // Add the user
  Future addUserData(email, firstName, lastName) async {
    try {
      // Add the user to the collection
      return await userRef.document(uid).setData({
        'email': email,
        'firstName' : firstName,
        'lastName' : lastName
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Fetch the user data
  Future fetchUserData() async {
    try {
      // fetch the specific user
      // using the user id
      return await userRef.document(uid).get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Fetch the products/items
  Future fetchProducts() async {
    try {
      return await itemRef.getDocuments();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Add to cart function
  Future addToCart(String itemId) async {
    try {
      return await cartRef.document().setData({
        'userId': uid,
        'itemId': itemId
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}