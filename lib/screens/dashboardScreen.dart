import 'package:flutter/material.dart';
import 'package:my_online_store_1/services/AuthService.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Auth service to call the logout
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Dashboard"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Welcome to your Dashboard!"),
            ElevatedButton(
              onPressed: () async {
                await _authService.logoutUser();
                Navigator.pushReplacementNamed(context, 'auth');
              }, 
              child: Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}