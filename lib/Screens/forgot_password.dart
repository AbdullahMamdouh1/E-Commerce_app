



import 'package:abdullah1/Screens/Login.dart';
import 'package:abdullah1/widget/formtext.dart';
import 'package:abdullah1/widget/snackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ForgotPassword extends StatefulWidget {
    ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();


  resetPassword() async{

    showDialog(
        context: context,
        builder:(context){
          return Center(
              child: CircularProgressIndicator(color: Colors.white,
              )
          );
        }
    );

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      if (!mounted) return;
      showSnackBar2(context, 'Done - Please check your email');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ));
    }on FirebaseAuthException catch (e) {
      showSnackBar(context, ' Error : ${e.code}');


  }
    if (!mounted)return;
   // Navigator.pop(context);



  }


    void dispose() {
      // TODO: implement dispose
      emailController.dispose();

      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
        elevation: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Text('Reset Password',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 20),
              Text('Enter the email associated with yor account and we will send you a link to reset your password ',style: TextStyle(fontSize: 18,),),

              SizedBox(height: 33),
              FromText(
                validator: (value) {
                  return value.contains(RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                      ? null
                      : 'Enter a valid email';
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controllerr: emailController,
                ispassword: false,
                TextInputTypeee: TextInputType.emailAddress,
                labelTextr: 'enter your email',
                prefixIconT: Icons.email_outlined,
                suffixIconn: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.visibility,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 33),
              Container(

                child: ElevatedButton(
                    onPressed: () async{
                      if (formKey.currentState!.validate()) {
                        resetPassword();




                      } else {
                        showSnackBar(context, 'Error');
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStatePropertyAll(Colors.blue),
                        padding: MaterialStatePropertyAll(
                            EdgeInsets.all(12)),
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(10)))),
                    child: isLoading
                        ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                        : Text(
                      'Reset Password ',
                      style: TextStyle(fontSize: 19),
                    )),
              ),




            ],

          ),
        ),
      ),
    );
  }
}
