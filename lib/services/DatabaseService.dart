// Service that is responsible for all of the 
// Firestore functionalities
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  // Collection reference for the user
  CollectionReference userRef = FirebaseFirestore.instance.collection("users");

  // Collection reference for the product
  CollectionReference itemRef = FirebaseFirestore.instance.collection("product");

  // Collection reference for the cart
  CollectionReference cartRef = FirebaseFirestore.instance.collection("cart");
  
  // Add the user
  Future addUserData(email, firstName, lastName) async {
    try {
      // Add the user to the collection
      return await userRef.doc(uid).set({
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
      return await userRef.doc(uid).get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Fetch the products/items
  Future fetchProducts() async {
    try {
      return await itemRef.get();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Add to cart function
  Future addToCart(String itemId) async {
    try {
      return await cartRef.doc().set({
        'userId': uid,
        'itemId': itemId
      });
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // Function to fetch the cart of the specific user
  Stream<QuerySnapshot> fetchCart() {
    try {
      return cartRef.
      where("userId", isEqualTo: uid)
      .snapshots();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Fetch the product based on the product id
  Future fetchItemInfo(String itemId) async {
    try {
      return await itemRef.doc(itemId).get();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Function to delete the cart based on the cartId
  Future deleteCart(String cartId) async {
    try {
      return await cartRef.doc(cartId).delete();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}