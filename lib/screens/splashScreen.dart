import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_online_store_1/services/AuthService.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // Auth service to call the checkLoggedIn function
  AuthService _authService = AuthService();

  @override
  void initState() { 
    super.initState();
    
    // Trigger the function when the widgets are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('done rendering the widgets');
      checkUser();
    });
  }

  checkUser() async {
    FirebaseUser user = await _authService.checkIsLoggedIn();
    if( user != null) {
      Navigator.pushReplacementNamed(context, 'dash');
    } else {
      Navigator.pushReplacementNamed(context, 'auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Text("Loading..."),
       ),
    );
  }
}