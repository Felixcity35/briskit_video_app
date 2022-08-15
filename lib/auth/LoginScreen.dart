// ignore_for_file: unnecessary_null_comparison, import_of_legacy_library_into_null_safe

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:movies_app/Screens/Home/movie_home.dart';
import 'package:movies_app/Screens/bottom_nav/app.dart';
import 'package:movies_app/Screens/bottom_nav/tab_homepage.dart';

import '../Components/progressDialog.dart';
import '../Helpers/Constants/myColors.dart';
import 'RegistrationScreen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login";
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

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
                height: 45.0,
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
                " Login ",
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
                        if (!emailEditingController.text.contains("@")) {
                          displayToastMessage(
                              "Email address is not valid", context);
                        } else if (passwordEditingController.text.isEmpty) {
                          displayToastMessage("password is required", context);
                        } else {
                          loginUser(context);
                        }
                      },
                      child: Container(
                        height: 50.0,
                        child: Center(
                          child: Text(
                            "Login",
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationScreen()));
                },
                child: Text("Don't have an account? Register here"),
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return progressDialogBar(
            message: "Authenticating please wait..",
          );
        });

    final User _firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailEditingController.text,
                password: passwordEditingController.text)
            .catchError((erMessage) {
      Navigator.pop(context);
      displayToastMessage(
          "Error: " + erMessage.toString().substring(15), context);
    }))
        .user;

    if (_firebaseUser != null) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CustomNavigatorHomePage()));
    } else {
      Navigator.pop(context);
      displayToastMessage("signIn error try again.", context);
    }
  }
}
