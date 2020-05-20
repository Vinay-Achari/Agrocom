import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'Profile.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   final _user = FirebaseAuth.instance;
   bool showspinner= false;
   String email;
   String pass;
   bool farmer=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag:'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/2.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                 email=value; //Do something with the user input.
                },
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color:Colors.grey,
                  ),
                  hintText: 'Enter your email',

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
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                 pass= value; //Do something with the user input.
                },

                decoration: InputDecoration(
                  hintText: 'Enter your password.',
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
              SizedBox(
                height: 24.0,
              ),

              Row(
                children: <Widget>[
                  SizedBox(
                    width: 120.0,
                  ),

                  Text(

                    'Are you a farmer?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                  Checkbox(value: farmer,
                      activeColor: Colors.green,
                      onChanged:(bool newValue){
                        setState(() {
                          farmer = newValue;
                        });

                        print(farmer);
                      }),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightGreenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: ()async {
                      setState(() {
                        showspinner=true;
                      });
                    try {
                      final
                      user = await _user.signInWithEmailAndPassword(
                          email: email, password: pass);
                      if (user != null) {

                        if(farmer)
                          Navigator.pushNamed(context, '/fourth');

                        else
                        Navigator.pushNamed(
                            context, '/third'); //Implement login functionality.


                        setState(() {
                          showspinner=false;
                        });
                      }
                    }
                    catch(e){
                      print(e);}

                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Log In',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
