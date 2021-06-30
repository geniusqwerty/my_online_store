import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_online_store_1/services/AuthService.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // key reference to the Form widget
  GlobalKey<FormState> _formKey = GlobalKey();
  // Auth service instance
  AuthService _authService = AuthService();
  // Variables that will hold the text field input
  String _email;
  String _password;

  // Variable to check if the authentication process is loading
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN PAGE"),
      ),
      body:
        // hide all of the text fields and button when loading is true
        // _isLoading ? 
        // Center(
        //   child: CircularProgressIndicator()
        // ) 
        // : Center(
        // child: Container(
       Center(
        child: Container(
          padding: EdgeInsets.all(20),
          // change the column to listview
          child: ListView(
            shrinkWrap: true,
            children: [
              // Add the logo
              Image.asset(
                "assets/images/shopping_logo.jpg",
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 30,
              ),
              // parent form field
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      // disable when the user triggered the loading
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "example@gmail.com",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "Email is required";
                        }
                        // Regex pattern for email
                        RegExp isEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                        if(!isEmail.hasMatch(value)){
                          return "Email is invalid!";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                           _email = value;                     
                        });
                      },
                    ),
                    // Add space
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: !_isLoading,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "********",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      validator: (value){
                        if(value.isEmpty) 
                          return "Password is required";
                        if(value.length < 6)
                          return "Password should be more than 5 characters";
                        // Regex pattern for determining uppercase characters
                        RegExp hasUpper = RegExp(r'[A-Z]');
                        // Regex pattern for determining lowercase characters
                        RegExp hasLower = RegExp(r'[a-z]');
                        // Regex pattern for determining digits
                        RegExp hasDigit = RegExp(r'\d');
                        // Regex patter for determining special characters
                        RegExp hasPunct = RegExp(r'[_!@#\$&*~-]');
                        if (!hasUpper.hasMatch(value))
                          return 'Password must have at least one uppercase character';
                        if (!hasLower.hasMatch(value))
                          return 'Password must have at least one lowercase character';
                        if (!hasDigit.hasMatch(value))
                          return 'Password must have at least one number';
                        if (!hasPunct.hasMatch(value))
                          return 'Passwordd need at least one special character like !@#\$&*~-';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                           _password = value;                     
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _isLoading ? Center( child: CircularProgressIndicator()) : Container(),
              ElevatedButton.icon(
                // disable when the user triggered the loading
                onPressed: _isLoading ? null : () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      _isLoading = true;                   
                    });
                    
                    print("All forms are validated");
                    // Old version code
                    // FirebaseUser user = await _authService.loginUser(_email, _password);
                    User user = await _authService.loginUser(_email, _password);
                    if(user != null) {
                      Navigator.pushReplacementNamed(context, 'dash', arguments: user.uid);
                    } else {
                      print('Error logging in!');
                      setState(() {
                        _isLoading = false;                   
                      });
                    }
                  } else {
                    print("Please check your input");
                  }
                }, 
                icon: Icon(Icons.login), 
                label: Text("LOGIN"),
              ),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : (){
                  widget.toggleScreen();
                }, 
                icon: Icon(Icons.arrow_left), 
                label: Text("No account yet? Sign up here"),
              ),
            ],
          )
        ),
      ),
    );
  }
}