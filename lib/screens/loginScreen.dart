import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // key reference to the Form widget
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN PAGE"),
      ),
      body: Center(
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
                    ),
                    // Add space
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    print("All forms are validated");
                  } else {
                    print("Please check your input");
                  }
                }, 
                icon: Icon(Icons.login), 
                label: Text("LOGIN"),
              ),
              ElevatedButton.icon(
                onPressed: (){
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