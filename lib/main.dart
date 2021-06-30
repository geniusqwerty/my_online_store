import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:my_online_store_1/screens/authScreen.dart';
import 'package:my_online_store_1/screens/cartScreen.dart';
import 'package:my_online_store_1/screens/dashboardScreen.dart';
import 'package:my_online_store_1/screens/itemInfoScreen.dart';
import 'package:my_online_store_1/screens/loginScreen.dart';
import 'package:my_online_store_1/screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// create the basic design
  // create two pages, sign up and login
  // create button that will toggle to each page
// add forms and validation
  // to login page
  // sign up page
// add additional validations
  // password
  // confirm password
  // checkbox
// additional updates, refine design
  // adding space between pages
  // making page scrollable
  // adding logo to login

// Add authentication to the app
// login, sign up
// additional updates, adding loading screen when authentication process is ongoing
// check if the user logged in previously
// logout

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // home: AuthScreen(),

      initialRoute: 'splash',
      routes: {
        'splash': (context) => SplashScreen(),
        'auth' : (context) => AuthScreen(),
        'dash' : (context) => DashboardScreen(),
        'itemInfo' : (context) => ItemInfoScreen(),
        'cart': (context) => CartScreen(),
      },

    );
  }
}