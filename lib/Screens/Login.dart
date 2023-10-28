import 'package:abdullah1/Screens/Home.dart';
import 'package:abdullah1/Screens/signup.dart';
import 'package:abdullah1/widget/formtext.dart';
import 'package:abdullah1/widget/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
          builder:(context){
            return Center(
                child: CircularProgressIndicator(color: Colors.white,
                ));
          }
      );




      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailControllerr.text, password: passwordControllerr.text);

      showSnackBar2(context, 'Done ');
    } on FirebaseAuthException catch (e) {
     showSnackBar(context, ' Error : ${e.code}');
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ));


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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 40),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Text(
                        'Welcome Back',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 40),
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
                      width: 250,
                      child: ElevatedButton(
                          onPressed: () async {
                            await logIn();
                            if (!mounted) return;
                          },
                          child: Text(
                            'Log in ',
                            style: TextStyle(fontSize: 19),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.blue),
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(12)),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15))))),
                    ),
                    SizedBox(
                      height: 15,
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
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 13),
                            ))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//abdullah@abdullah240.onmicrosoft.com    Asdfghjklasdfghjkl1
