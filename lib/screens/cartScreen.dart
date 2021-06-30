import 'package:flutter/material.dart';
import 'package:my_online_store_1/services/DatabaseService.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String userId;
  
  @override
  Widget build(BuildContext context) {
    userId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              // call the function to render the list of cart items
              displayCartItems(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to render the items
  Widget displayCartItems() {
    // use the StreamBuilder to render the changes on the data
    return StreamBuilder(
      stream: DatabaseService(uid: userId).fetchCart(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          // hold to the value of the cart items
          List carts = [];
          // old code
          // snapshot.data.documents.map((cart) {
          snapshot.data.docs.map((cart) {
            print(cart['itemId']);
            carts.add(cart);
          }).toList();

          return Expanded(
            child: ListView.builder(
              itemCount: carts.length,
              itemBuilder: (context, index){
                return FutureBuilder(
                  future: DatabaseService().fetchItemInfo(carts[index]['itemId']),
                  builder: (BuildContext cxt, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      return ListTile(
                        // tile format image, item name, item price + currency
                        leading: Image.network(snapshot.data['image'], height: 100, width: 100,),
                        title: Text(snapshot.data['itemName']),
                        subtitle: Text("${snapshot.data['itemPrice']} ${snapshot.data['currency']}"),
                        // remove the item from your cart
                        trailing:  IconButton(
                          icon: Icon(Icons.delete_forever),
                          onPressed: () async {
                            // Old code
                            // await DatabaseService().deleteCart(carts[index].reference.documentID);
                            await DatabaseService().deleteCart(carts[index].id);
                           
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Item has been removed from your cart!"))
                            );
                          },
                        ),
                        onTap: () {
                          Map<String, dynamic> args = new Map();
                          args['userId'] = userId;
                          args['item'] = snapshot.data;
                          Navigator.pushNamed(context, 'itemInfo', arguments: args);
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                );
              }),
          );

        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}