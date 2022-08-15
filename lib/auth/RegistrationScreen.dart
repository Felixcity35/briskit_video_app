// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movies_app/Screens/bottom_nav/app.dart';

import '../Components/progressDialog.dart';
import 'LoginScreen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register";
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  var nameInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              Image(
                image: AssetImage("assets/images/log.png"),
                height: 150.0,
                width: 200.0,
                alignment: Alignment.topCenter,
              ),
              SizedBox(
                height: 1.0,
              ),
              Text(
                "Registration",
                style: TextStyle(fontSize: 24.0, fontFamily: "Brand Bold"),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 1.0,
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextField(
                      controller: passwordEditingController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 14.0),
                          hintStyle:
                              TextStyle(fontSize: 10.0, color: Colors.grey)),
                      style: TextStyle(fontSize: 14.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    RaisedButton(
                      color: Colors.pink,
                      textColor: Colors.white,
                      onPressed: () {
                        if (passwordEditingController.text.length < 6) {
                          displayToastMessage(
                              "password must be at least 6 characters",
                              context);
                        } else if (!emailEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email address is not valid", context);
                      
                        } else {
                          registerNewUser(context);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 18.0, fontFamily: "Brand Bold"),
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ),
                    ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("Already have an account? Login here"),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return progressDialogBar(
            message: "Registering please wait...",
          );
        });

    nameInput = nameEditingController.text;

    final User _firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailEditingController.text,
                password: passwordEditingController.text)
            .catchError((erMessage) {
      Navigator.pop(context);
      displayToastMessage("Error: " + erMessage.toString(), context);
    }))
        .user;

    // ignore: unnecessary_null_comparison
    if (_firebaseUser != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomNavigatorHomePage()));
    } else {
      Navigator.pop(context);
      // displayToastMessage("data not save", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
