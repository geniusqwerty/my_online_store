import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_online_store_1/services/AuthService.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key, this.toggleScreen}) : super(key: key);

  final Function toggleScreen;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
    // variable to hold the Form widget instance
  GlobalKey<FormState> _formKey = GlobalKey();

  // Variables to hold
  String _email;
  String _password;
  bool _didAgree = false;

  // Authentication service
  AuthService _authService = AuthService();

  // Variable to determine if the authentication process is loading
  bool _isLoading =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER PAGE"),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          // convert the column to listview
          // to activate the scrolling
          child: ListView(
            shrinkWrap: true,
            children: [
              // Form widget to house the form fields
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // form field widgets with validator properties
                    TextFormField(
                      // disable the text field when it is loading
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: "First name",
                        hintText: "John",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "First name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: !_isLoading,
                      decoration: InputDecoration(
                        labelText: "Last name",
                        hintText: "Doe",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return "Last name is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
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
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      enabled: !_isLoading,
                      // hide the input of the textfield
                      // similar to passwords
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Confirm password
                    TextFormField(
                      enabled: !_isLoading,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "********",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderSide: new BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(15),
                        )
                      ),
                      validator: (value){
                        // validation is to check the current value to the 
                        // value on the Password field
                        if(value != _password) {
                          return "Passwords must match!";
                        }
                        return null;
                      },
                    ),
                    // Checkbox for Agreement
                    FormField(
                      enabled: !_isLoading,
                      initialValue: _didAgree,
                      validator: (value) {
                        if(!value)
                          return "You must agree before signing up";
                        return null;
                      },
                      // builder for the custom form field
                      builder: (FormFieldState<bool> state) {
                        return Column(
                          children: [
                            // the content of the checkbox should be the form field state
                            Row(
                              children: [
                                Checkbox(
                                  value: state.value, 
                                  onChanged: (val){
                                    _didAgree = val;
                                    state.didChange(val); // this function will also update this form's state value
                                  }
                                ),
                                Text("I agree to the terms.")
                              ],
                            ),
                            state.errorText == null
                            ? Text("")
                            : Text(state.errorText, style: TextStyle(color: Colors.red))
                          ],
                        );
                      }
                    )

                  ],
                ),
              ),
              _isLoading ? Center( child: CircularProgressIndicator()) : Container(),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                // return null on onPress to disable it
                onPressed: _isLoading ? null : () async {
                  // trigger the validator property function of each form field
                  // present inside the Form widget
                  if(_formKey.currentState.validate()) {
                    print("User is ready to register");
                    // set the isLoading to true to show the loading indicator
                    setState(() {
                      _isLoading = true;          
                    });
                    // Call the register function
                    FirebaseUser user = await _authService.registerUser(_email, _password);
                    if(user != null) {
                      Navigator.pushReplacementNamed(context, 'dash');
                    } else {
                      print('Error logging in!');
                      // hide the error when Firebase returned an error
                      setState(() {
                      _isLoading = false;          
                    });
                    }
                  } else {
                    print("Please validate your info");
                  }
                }, 
                icon: Icon(Icons.app_registration), 
                label: Text("REGISTER"),
              ),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : (){
                  widget.toggleScreen();
                }, 
                icon: Icon(Icons.arrow_left), 
                label: Text("Already have an account? Login up here"),
              ),
            ],
          )
        ),
      ),
    );
  }
}