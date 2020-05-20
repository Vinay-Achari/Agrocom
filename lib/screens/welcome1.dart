import 'package:flutter/material.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Expanded(
              flex: 5,
              child: Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/2.png'),
                  height: 200.0,
                ),
              ),
            ),

            Expanded(
              flex:3,
              child: Center(
                child: Text(

                  'Agrocom',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 80.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex:5,
              child:   Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("images/1.jpg"),
                      ))




              ),
            ),
            Expanded(
              flex:3,
              child: Text(

                'Be your own trader',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Material(

                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 10.0,

                child:MaterialButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/');
                  },
                  minWidth: 80.0,

                  child:Text(
                      'click to trade >',
                      style:TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      )
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
