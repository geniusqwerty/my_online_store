import 'package:flutter/material.dart';
import 'package:my_online_store_1/screens/loginScreen.dart';
import 'package:my_online_store_1/screens/registerScreen.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // variable that will determine which screen to show
  bool _isLogin = true;
  // function to toggle the screens
  void toggleScreen() {
    setState(() {
      _isLogin = !_isLogin;      
    });
  }

  @override
  Widget build(BuildContext context) {
    // pass the function to each screen widget as a parameter
    return _isLogin ? LoginScreen(toggleScreen: toggleScreen,) : RegisterScreen(toggleScreen: toggleScreen,);
  }
}