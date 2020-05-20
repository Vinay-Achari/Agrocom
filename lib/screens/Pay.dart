import 'package:flutter/material.dart';

class Pay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('🛒Agrocom',
        style: TextStyle(
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),),
    backgroundColor: Colors.lightGreenAccent,
    ),
    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex:1,
          child:Material(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            elevation: 10.0,

            child:MaterialButton(
              onPressed: (){

              },
              minWidth: 10.0,

              child:Text(
                  'UPI Google Pay',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),

            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex:1,
          child:Material(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            elevation: 10.0,

            child:MaterialButton(
              onPressed: (){

              },
              minWidth: 10.0,

              child:Text(
                  'Netbanking',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),

            ),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),
        Expanded(
          flex:1,
          child:Material(
            color: Colors.deepOrangeAccent,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            elevation: 10.0,

            child:MaterialButton(
              onPressed: (){

              },
              minWidth: 10.0,

              child:Text(
                  'Credit/Debit Card',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),

            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),



        Expanded(
          flex:1,
          child:Material(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            elevation: 10.0,

            child:MaterialButton(
              onPressed: (){

              },
              minWidth: 10.0,

              child:Text(
                  'Cash on Delivery',
                  style:TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  )
              ),

            ),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

      ],
    )
    );
  }
}
