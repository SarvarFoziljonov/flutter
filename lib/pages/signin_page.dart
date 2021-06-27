import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/home_page.dart';
import 'package:flutter_instaclone/pages/signup_page.dart';
import 'package:flutter_instaclone/services/auth_service.dart';
import 'package:flutter_instaclone/services/prefs_service.dart';
import 'package:flutter_instaclone/services/utils_service.dart';
class SigninPage extends StatefulWidget {
  static final String id = "signin_page";
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  _callSignUpPage () {
    Navigator.pushReplacementNamed(context, SignupPage.id);
  }

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false;

  _doSignIn() {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    if(email.isEmpty || password.isEmpty) {
      Utils.fireToast("check your info");
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
    AuthService.signInUser(context, email, password).then((firebaseUser) => {
      _getFirebaseUser(firebaseUser),
    });
  }

  _getFirebaseUser(FirebaseUser firebaseUser) async {
    setState(() {
      isLoading = false;
    });
    if (firebaseUser != null) {
      await Prefs.saveUserId(firebaseUser.uid);
      Navigator.pushReplacementNamed(context, HomePage.id);
    } else {
      Utils.fireToast("Check your email or password");
    }
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
                            style: TextStyle(color: Colors.white),
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
                            style: TextStyle(color: Colors.white),
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
                        //signin button
                        GestureDetector(
                          onTap: (){
                            _doSignIn();
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
                                child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 17),),
                              ),

                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(color: Colors.white, fontSize: 18),),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: _callSignUpPage,
                        child: Text("Sign Up", style: TextStyle(color: Colors.white, fontSize: 18),),
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
