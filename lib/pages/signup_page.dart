import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/model/user_model.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
import 'package:flutter_instaclone/services/auth_service.dart';
import 'package:flutter_instaclone/services/data_service.dart';
import 'package:flutter_instaclone/services/prefs_service.dart';
import 'package:flutter_instaclone/services/utils_service.dart';

import 'home_page.dart';
class SignupPage extends StatefulWidget {
  static final String id = "signup_page";
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var isLoading = false;
  _callSignInPage (){
    Navigator.pushReplacementNamed(context, SigninPage.id);
  }
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasController = TextEditingController();

  _doSignUp(){
    String name = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String confirmpas = confirmpasController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;
    if(password != confirmpas) {
      Utils.fireToast("Password and confirm password doesn't match");
      return;
    }
    if (!Utils().validatePassword(password)) {
      Utils.fireToast("Please, check your password!");
      return;
    }

    if (!Utils().validateEmail(email)) {
      Utils.fireToast("Please, check your email!");
      return;
    }

    setState(() {
      isLoading = true;
    });
    User user = new User (fullname: name, email: email, password: password);
    AuthService.signUpUser(context, name, email, password).then((value) =>
    {
      _getFirebaseUser(user, value),
    });
  }

  _getFirebaseUser(User user, Map<String, FirebaseUser> map) async {
    setState(() {
      isLoading = false;
    });
    FirebaseUser firebaseUser;
    if (!map.containsKey("SUCCESS")) {
      if (map.containsKey("ERROR_EMAIL_ALREADY_IN_USE"))
        Utils.fireToast("Email already in use");
      if (map.containsKey("ERROR"))
        Utils.fireToast("Try again later");
      return;
    }
    firebaseUser = map["SUCCESS"];
    if (firebaseUser == null) return;

    await Prefs.saveUserId(firebaseUser.uid);
    DataService.storeUser(user).then((value) => {
      Navigator.pushReplacementNamed(context, HomePage.id),
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(252, 175, 69, 1),
                  Color.fromRGBO(245, 96, 64, 1),
                ]
            ),

          ),

          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Instagram Clone", style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: 'Billabong'),),
                        SizedBox(height: 15,),
                        //fullname
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller: fullnameController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "Fullname",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white54,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        // email
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller: emailController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "Email",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white54,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        // password
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller: passwordController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white54,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        // confirm password
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white54.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: TextField(
                            controller: confirmpasController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white54,
                                )
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        //signin button
                        GestureDetector(
                          onTap: (){
                            _doSignUp();
                          },
                          child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white54.withOpacity(0.2), width: 2,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 17),),
                              )

                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: TextStyle(color: Colors.white, fontSize: 18),),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: _callSignInPage,
                        child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18),),
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),

                ],
              ),
              isLoading ?
              Center(
                child: CircularProgressIndicator(),
              ): SizedBox.shrink(),

            ],
          ),

        ),
      ),
    );
  }
}
