import 'package:abdullah1/Screens/Home.dart';
import 'package:abdullah1/Screens/Login.dart';
import 'package:abdullah1/Screens/verify_email.dart';
import 'package:abdullah1/widget/color.dart';
import 'package:abdullah1/widget/formtext.dart';
import 'package:abdullah1/widget/snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' show basename;
import "dart:math";


class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Global variable
  String? imgName;


  File? imgPath;

  uploadImage(dynamic CameraAndGallery) async {
    final pickedImg = await ImagePicker().pickImage(source: CameraAndGallery);
    try {
      if (pickedImg != null) {
        setState(() {imgPath = File(pickedImg.path);
        imgName = basename(pickedImg.path);
        int random = Random().nextInt(9999999);
        imgName = "$random$imgName";


        });
      } else {print("NO img selected");}
    } catch (e) {print("Error => $e");}

    Navigator.pop(context);
  }



  showModalBottomSheet1(){


    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(22),

          height:  200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async{
                  await uploadImage( ImageSource.camera);



                },
                child: Row(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(
                      width: 10,
                    ),
                    Text("From camera",style: TextStyle(fontSize: 20,color: Colors.black),)

                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: () async{
                  await  uploadImage(ImageSource.gallery);


                },
                child: Row(
                  children: [
                    Icon(Icons.photo_album_outlined,),
                    SizedBox(
                      width: 10,
                    ),
                    Text("From Gallery",style: TextStyle(fontSize: 20,color: Colors.black),)

                  ],
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(fontSize: 22),
                  ))
            ],
          ),
        );
      },
    );
  }



  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNemeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isSee = true;
  bool inPassword8char = false;
  bool inPassword1num = false;
  bool inPasswordupp = false;
  bool inPasswordlow = false;
  bool inPasswordspec = false;

//     1
  onPasswordChanged(String password) {
    setState(() {
      inPassword8char = false;
      if (password.contains(RegExp(r'.{8,}'))) {
        inPassword8char = true;
      }
    });
  }

  //     2
  onPasswordChanged2(String password) {
    setState(() {
      inPassword1num = false;
      if (password.contains(RegExp(r'(?=.*?[0-9])'))) {
        inPassword1num = true;
      }
    });
  }

  //     3
  onPasswordChanged3(String password) {
    setState(() {
      inPasswordupp = false;
      if (password.contains(RegExp(r'(?=.*[A-Z])'))) {
        inPasswordupp = true;
      }
    });
  }

  //     4
  onPasswordChanged4(String password) {
    setState(() {
      inPasswordlow = false;
      if (password.contains(RegExp(r'(?=.*[a-z])'))) {
        inPasswordlow = true;
      }
    });
  }

  //     5
  onPasswordChanged5(String password) {
    setState(() {
      inPasswordspec = false;
      if (password.contains(RegExp(r'(?=.*?[!@#\$&*~])'))) {
        inPasswordspec = true;
      }
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Upload image to firebase storage
      final storageRef = FirebaseStorage.instance.ref(imgName);
      await storageRef.putFile(imgPath!);
      String url = await storageRef.getDownloadURL();


      CollectionReference users =
          FirebaseFirestore.instance.collection('usersss');

      users
          .doc(credential.user!.uid)
          .set({
        'username': userNemeController.text,
        'imglink': url,



          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));








    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // print('The password provided is too weak.');
        showSnackBar(context, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        //  print('The account already exists for that email.');
        showSnackBar(context, 'The account already exists for that email.');
      } else {
        showSnackBar(context, 'Error - Please try again late');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 25, top: 60, right: 25),
            child: Column(
              children: [

                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue

                  ),
                  child: Stack(
                    children: [

                      imgPath == null ?

                      CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 60,

                        backgroundImage: AssetImage("assets/icons/icons8-avatar-.png")
                    )     :
                        ClipOval(
                          child: Image.file(imgPath!,height: 145,width: 145
                          ,fit: BoxFit.cover,

                          ),


                        ),



                        Positioned(
                          bottom: -3,
                          left: 85,
                          child: IconButton(    onPressed: () {
                            showModalBottomSheet1();

                          },  icon: Icon(Icons.add_a_photo_rounded)),
                        ),

                    ]

                  ),
                ),




                Column(
                  children: [
                    Text(
                      'Create your account!',
                      style: TextStyle(color: Colors.black54, fontSize: 30),
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      FromText(
                        validator: (value) {
                   if (value == null || value.isEmpty) {
                           return 'Please enter some text';
                                }
                                 return null;},
                        controllerr:userNemeController ,
                        ispassword: true,
                        TextInputTypeee: TextInputType.text,
                        labelTextr: 'enter your username',
                        prefixIconT: Icons.person,
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
                      SizedBox(
                        height: 30,
                      ),
                      FromText(
                        validator: (value) {
                          if ((value.contains(RegExp(r'.{8,}'))) &&
                              (value.contains(RegExp(r'(?=.*?[0-9])'))) &&
                              ((value.contains(RegExp(r'[!@#\$&*~]')))) &&
                              (value.contains(RegExp(
                                  r'[Q,W,E,R,T,Y,U,I,O,P,A,S,D,F,G,H,J,K,L,Z,X,C,V,B,N,M,]'))) &&
                              (value.contains(RegExp(
                                  r'[q,w,e,r,t,y,u,i,o,p,a,s,d,f,g,h,j,k,l,z,x,c,v,b,n,m,]')))) {
                            return null;
                          } else {
                            return 'Enter at least 8 characters';
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controllerr: passwordController,
                        ispassword: isSee ? true : false,
                        TextInputTypeee: TextInputType.visiblePassword,
                        labelTextr: 'enter your password',
                        prefixIconT: Icons.lock,
                        onChangedd: (password) {
                          onPasswordChanged(password);
                          onPasswordChanged2(password);
                          onPasswordChanged3(password);
                          onPasswordChanged4(password);
                          onPasswordChanged5(password);
                        },
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
                        height: 13,
                      ),

                      //    ************

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 15),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: inPassword8char
                                          ? purple
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('At least 8 characters'),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 15),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: inPassword1num
                                          ? purple
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('At least 1 number'),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 15),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          inPasswordupp ? purple : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('Has Uppercase'),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 15),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          inPasswordlow ? purple : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('Has lowercase'),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 20,
                                  child: Icon(Icons.check,
                                      color: Colors.white, size: 15),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: inPasswordspec
                                          ? purple
                                          : Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.shade400)),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text('Has Special Characters '),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 40,
                      ),
///////////////////////////////////////////////////////////////////////////////////
                      Container(
                        width: 350,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate() && imgName !=null && imgPath != null) {
                                await register();

                                if (!mounted) return;

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Home()                // VerifyEmailPage(),
                                    ));
                              } else {
                                showSnackBar(context, 'Error');
                              }
                            },
                            child: isLoading
                                ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    'Sign Up ',
                                    style: TextStyle(fontSize: 19),
                                  ),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.blue),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.all(12)),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Do have an account?',
                            style:
                                TextStyle(fontSize: 16, color: Colors.black54),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
