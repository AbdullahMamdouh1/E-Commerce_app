import 'package:abdullah1/Provider/google_signin.dart';
import 'package:abdullah1/Screens/Home.dart';
import 'package:abdullah1/Screens/forgot_password.dart';
import 'package:abdullah1/Screens/signup.dart';
import 'package:abdullah1/widget/color.dart';
import 'package:abdullah1/widget/formtext.dart';
import 'package:abdullah1/widget/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isSee = true;
  final emailControllerr = TextEditingController();
  final passwordControllerr = TextEditingController();

  logIn() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          });

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControllerr.text, password: passwordControllerr.text);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, ' Error : ${e.code}');
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailControllerr.dispose();
    passwordControllerr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 0, left: 40, right: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      'Welcome Back!',
                      style: TextStyle(
                          color: black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Enter your email and password to log in to your account',
                    style: TextStyle(
                      color: black2,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  FromText(
                    ispassword: false,
                    TextInputTypeee: TextInputType.emailAddress,
                    labelTextr: 'enter your email',
                    prefixIconT: Icons.email_outlined,
                    controllerr: emailControllerr,
                    suffixIconn: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.visibility,
                          color: Colors.white,
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FromText(
                    ispassword: isSee ? true : false,
                    TextInputTypeee: TextInputType.visiblePassword,
                    labelTextr: 'enter your password',
                    prefixIconT: Icons.lock,
                    controllerr: passwordControllerr,
                    suffixIconn: IconButton(
                        onPressed: () {
                          setState(() {
                            isSee = !isSee;
                          });
                        },
                        icon: isSee
                            ? Icon(
                                Icons.visibility,
                              )
                            : Icon(
                                Icons.visibility_off,
                              )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () async {
                          await logIn();
                          if (!mounted) return;
                        },
                        child: Text(
                          'Log in ',
                          style: TextStyle(fontSize: 19, color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(blue),
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(12)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))))),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword(),
                            ));
                      },
                      child: Text(
                        'Forgot Password ?',
                        style: TextStyle(
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                            color: blue),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Do not have an account?',
                        style: TextStyle(fontSize: 13),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 13,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 17,
              ),
              SizedBox(
                width: 299,
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 0.6,
                      color: black2,
                    )),
                    Text(
                      "OR",
                      style: TextStyle(
                        color: blue,
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 0.6,
                      color: Colors.blue,
                    )),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 27),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoogleSignIn.googlelogin();
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.red, width: 1)),
                            child: SvgPicture.asset(
                              "assets/icons/icons8-google (1).svg",
                              color: Colors.red[400],
                              height: 27,
                            ),
                          ),
                        ),
                      ]))
            ],
          ),
        ),
      ),
    );
  }
}

//abdullah@abdullah240.onmicrosoft.com    Asdfghjklasdfghjkl1
