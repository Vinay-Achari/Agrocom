

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Profile.dart';





  final _firestore = Firestore.instance;
FirebaseUser loggedinUser;
String finalveg;
String finalcount;
String finalprice;

const kstyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.w900,
);
const kstyle1 = TextStyle(
  fontSize: 40.0,
  fontWeight: FontWeight.w500,
  color: Colors.white,
);

class Farmerpage1 extends StatefulWidget {

  @override
  _Farmerpage1State createState() => _Farmerpage1State();
}

class _Farmerpage1State extends State<Farmerpage1> {

  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getCurrentuser();
  }

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
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),
        ],
        title: Text('🛒Agrocom',
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        ),),
        backgroundColor: Colors.lightGreenAccent,
      ),
      drawer: Drawer(

        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightGreenAccent,
              ),
              child: Text(
                '🛒Agrocom',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle,
                color: Colors.blueGrey,),
              title: Text('Profile '),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Profile(
                            user: loggedinUser.email,
                            photo:
                            'https://cdn.iconscout.com/icon/free/png-256/farmer-73-448498.png')));
              },
            ),
            ListTile(
              leading: Icon(Icons.message,
                color: Colors.blueGrey,),
              title: Text('Feedback'),
              onTap: (){
                Navigator.pushNamed(context,'/seventh');
              },
            ),
            ListTile(
              leading: Icon(Icons.add_shopping_cart,
                color: Colors.blueGrey,),
              title: Text('Previous Orders'),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(6),
        children: <Widget>[
          Column(
            children: <Widget>[

              Center(
                child: Card(
                  child: Text(
                    'Select the veggie and no. of units .',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),

              Center(
                child: Card(
                  child: Text(
                    'Each unit is 250g',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              buildCard('Potato'),
              buildCard('Onion'),
              buildCard('Tomato'),
              buildCard('Capsicum'),
              buildCard('Beans'),
              buildCard('Raddish'),
              buildCard('Carrot'),
              buildCard('DrumStick'),
              buildCard('Bottleguard'),
              buildCard('Brinjal'),
              buildCard('Peas'),
              buildCard('Cauliflower'),
              buildCard('Cabbage'),
              buildCard('Beetroot'),

            ],
          ),
        ],
      ),
    );
  }

  Card buildCard(String veg) {


    String price;
    String count;
    final textmessagecontroller = TextEditingController();
    final textmessagecontroller1 = TextEditingController();

    bool boolveg = false;
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
      
        Text(
          '$veg',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
         CupertinoSwitch(
            value: boolveg,
            onChanged: (bool newValue) {
              setState(() {
                boolveg = newValue;
                finalveg = veg;
                print(finalveg);
              });
            },
          ),
      RaisedButton(

       color: Colors.green,
            disabledColor: Colors.white70,

            child: Text('Upload'),
            onPressed: ()async{

    textmessagecontroller.clear();
    textmessagecontroller1.clear();
    print(finalveg);
    if(finalcount!=null || finalprice!=null) {
      var add = _firestore.collection('messages').add({
        'text': finalveg,
        'sender': loggedinUser.email,
        'price': finalprice,
        'count': finalcount,


      });
    }
    showDialog(context: context,
    builder:(BuildContext context) =>CupertinoAlertDialog(
      title: Text('Alert'),
      content:Text('Data has been uploaded'),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('OK'),
          onPressed: (){
            print('done');
            Navigator.of(context).pop();
          },
        ),
      ],
    ));

    textmessagecontroller.clear();
    textmessagecontroller1.clear();


        },
          ),
]),


          TextField(
            controller: textmessagecontroller,
            textAlign: TextAlign.center,

            onChanged: (value) {
              count = value;
              finalcount = count;
              print(finalcount); //Do something with the user input.
            },
            decoration: InputDecoration(
              hintText: 'Enter the no of units',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
          ),
          TextField(
            controller: textmessagecontroller1,
            textAlign: TextAlign.center,
            onChanged: (value) {
              price = value;
              finalprice= price;
              print(finalprice); //Do something with the user input.
            },
            decoration: InputDecoration(
              hintText: 'Enter the price',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent, width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.lightGreenAccent, width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
            ),
          ),

],
      ),
    );
  }
}
