import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/signin_page.dart';
class SignupPage extends StatefulWidget {
  static final String id = "signup_page";
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  _callSignInPage (){
    Navigator.pushReplacementNamed(context, SigninPage.id);
  }
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpas = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(193, 53, 132, 1),
                Color.fromRGBO(131, 58, 180, 1),
              ]
          ),

        ),

        child: Column(
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
                      style: TextStyle(color: Colors.white),
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
                  // confirm password
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white54.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: TextField(
                      controller: confirmpas,
                      style: TextStyle(color: Colors.white),
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
                    onTap: (){},
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

      ),
    );
  }
}
