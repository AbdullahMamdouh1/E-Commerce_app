import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetDataFromFirestore extends StatefulWidget {
  final String documentId;

  const GetDataFromFirestore({super.key, required this.documentId});

  @override
  State<GetDataFromFirestore> createState() => _GetDataFromFirestoreState();
}

class _GetDataFromFirestoreState extends State<GetDataFromFirestore> {
  final usernameDilogController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('usersss');

  myDialog(Map data, mykay) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: usernameDilogController,
                    maxLength: 20,
                    decoration: InputDecoration(hintText: "${data[mykay]}")),
                SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pop(context);
                          });
                          users
                              .doc(credential!.uid)
                              .update({mykay: usernameDilogController.text});
                        },
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 22),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 22),
                        )),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('usersss');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          ////////////////////////////////////////
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "UserName: ${data['username']} ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            myDialog(data, 'username');

                            //dilog

                            /*
                                  OR

                      showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11) ),
                                child: Container(
                                  padding: EdgeInsets.all(22),

                                  height: 200,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextField(
                        controller: usernameDilogController ,
                        maxLength: 20,
                        decoration: InputDecoration(hintText: "${data['username']}")),
                                      SizedBox(
                      height: 22,
                                      ),
                                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pop(context);
                              });
                              users.doc(credential!.uid).update({"username": usernameDilogController.text });




                            },
                            child: Text(
                              "Edit",
                              style: TextStyle(fontSize: 22),
                            )),
                        TextButton(
                            onPressed: () {

                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 22),
                            )),
                      ],
                                      )
                                    ],
                                  ),
                                ),
                              );

                       */
                          },
                          icon: Icon(Icons.edit)),




                      IconButton(onPressed: () {
                        setState(() {
                          users.doc(credential!.uid).update({"username": FieldValue.delete()});
                        });




                      }, icon: Icon(Icons.delete)),
                    ],
                  )
                ],
              ),
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
