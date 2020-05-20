import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  Profile({this.user,this.photo});
  String user;

String photo;

  @override
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image(
                image:NetworkImage(photo),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: Text('User : $user',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),),
            )
          ],
        ),
      ),
    );
  }

}

