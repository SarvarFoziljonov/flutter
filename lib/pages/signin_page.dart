import 'package:flutter/material.dart';
import 'package:flutter_instaclone/pages/signup_page.dart';
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
                          child: Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 17),),
                        )

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

      ),
    );
  }
}
