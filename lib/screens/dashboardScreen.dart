import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:my_online_store_1/services/AuthService.dart';
import 'package:my_online_store_1/services/DatabaseService.dart';


class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Auth service to call the logout
  AuthService _authService = AuthService();

  // Get the value from the navigator
  String userId;

  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context).settings.arguments;
    print(userId);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Dashboard"),
        actions: [ 
          ElevatedButton(
            onPressed: () async {
              await _authService.logoutUser();
              Navigator.pushReplacementNamed(context, 'auth');
            }, 
            child: Text("Logout"),
          ),
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Text("Welcome to your Dashboard!"),
              displayUserdata(),
              displayItems(),
              
              // Button to navigate to the Cart Screen
              ElevatedButton.icon(
                onPressed: () {
                  // Simulate the crash
                  // FirebaseCrashlytics.instance.crash();
                  Navigator.pushNamed(context, 'cart');
                }, 
                icon: Icon(Icons.shopping_bag_outlined), 
                label: Text("My Cart")),
            ],
          ),
        ),
      ),
    );
  }

  // Fetch and display the first and last name of the user
  Widget displayUserdata() {
    return new FutureBuilder(
      future: DatabaseService(uid: userId).fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          if(snapshot.data != null && snapshot.data.exists) {
            String firstName = snapshot.data['firstName'];
            String lastName = snapshot.data['lastName'];
            return Text(
              "Welcome ${firstName} ${lastName}!",
              style: TextStyle(
                fontSize: 20,
              ),
            );
          } else {
            return Container();
          }
        } else {
          return new CircularProgressIndicator();
        }
      }
    );
  }

  // Render the items/products
  Widget displayItems() {
    return FutureBuilder(
      future: DatabaseService().fetchProducts(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          if( snapshot.data != null ) {
            // Map the documents first

            // List to put the documents
            List items = [];
            // Old code
            // snapshot.data.documents.map((item) {
            snapshot.data.docs.map((item) {
              items.add(item);
            }).toList();
            return Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  // ListTile
                  // leading: image, title and subtitle, item name and price
                  // trailing add to cart button
                  return ListTile(
                    leading: Image.network(items[index]['image'], height: 100, width: 100,),
                    title: Text(items[index]['itemName']),
                    subtitle: Text("${items[index]['itemPrice']} ${items[index]['currency']}"),
                    trailing:  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        print("Added to cart");
                        // Old code
                        // await DatabaseService(uid: userId).addToCart(items[index].reference.documentID);
                        await DatabaseService(uid: userId).addToCart(items[index].id);
                        // Show a message on the Snackbar confirming that we've added an item to the cart
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Item has been added to cart!"))
                        );
                      },
                    ),
                    onTap: () {
                      // Since we cannot put two or more variables directly to the arguments
                      // we can create a Map variable that will contain the needed variables
                      Map<String, dynamic> args = new Map();
                      args['userId'] = userId;
                      args['item'] = items[index];
                      Navigator.pushNamed(context, 'itemInfo', arguments: args);
                    },
                  );
                }
              )
            );

          } else {
            return Container();
          }
        } else {
          return new CircularProgressIndicator();
        }
      }
    );
  }
}