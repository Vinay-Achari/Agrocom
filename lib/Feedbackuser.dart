import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





final _firestore = Firestore.instance;
FirebaseUser loggedinUser;

class Feedbackuser extends StatelessWidget {
  String feedback;
  final textmessagecontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;
  @override


  void getCurrentuser() async {
    try {
      final user = await _auth.currentUser();

      if (user != null) {
        loggedinUser = user;
        print(loggedinUser.email);
      }
    } catch (e) {
      print(e);
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: null,
        title: Hero(
          tag: 'head',
          child: Text('🛒Agrocom',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,

            ),),
        ),
        backgroundColor: Colors.lightGreenAccent,
      ),
      body:SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            TextField(
              controller: textmessagecontroller,
              textAlign: TextAlign.center,

              onChanged: (value) {
                feedback= value;
              },

              decoration: InputDecoration(

                hintText: 'Please give your feedback/complaint',
                hintStyle:TextStyle(
                  color: Colors.grey,
                ),
                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightGreenAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.lightGreenAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
onPressed: (){
  textmessagecontroller.clear();

  print(feedback);
  var add = _firestore.collection('Feedback').add({
    'feedback': feedback,




  });

  showDialog(context: context,
      builder:(BuildContext context) =>CupertinoAlertDialog(
    title: Text('Alert'),
    content:Text('Feedback recieved , we will contact you shortly!!'),
    actions: <Widget>[
    CupertinoDialogAction(
    isDefaultAction: true,
    child: Text('OK'),
    onPressed: (){
      print('done');
      Navigator.of(context).pop();
    },
  ),
  ]
  ),
  );
},
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Submit',
                  ),
                ),
              ),
            ),
          ],
        ),

      ),

    );
  }
}
