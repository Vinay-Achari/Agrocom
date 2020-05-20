import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

final _firestore = Firestore.instance;

FirebaseUser loggedinUser;




class Cart extends StatefulWidget {

  @override

  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
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
  Tooltip(
  message: 'Go back to order',
  child: IconButton(
  icon: Icon(Icons.arrow_back,
  color: Colors.blueGrey,),
  onPressed: (){
  Navigator.pushNamed(context, '/third');
  },
  ),
  ),

  ],
  title: Hero(
    tag: 'head',
    child: Text('🛒CART',
    style: TextStyle(
      color: Colors.blueGrey,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    )),
  ),
  backgroundColor: Colors.lightGreenAccent,
  ),
  body: SafeArea(
child: Column(
  children: <Widget>[
    MessagesStream(),
    Bottombutton()

    ])


),
  );

  }

  }

class MessagesStream extends StatelessWidget {
  @override
  String vegurl;
  var userprice=0;

  String id;
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('cart').snapshots(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ));
        }

        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageWidgets = [];
        for (var message in messages) {
          id= message.documentID;
          final messageText = message.data['veggie'];
          final messageSender = message.data['sender'];
          final messageprice=message.data['price'];
          final messagecount =message.data['count'];
          final currentuser=loggedinUser.email;




          if(messageText=='Carrot')
            vegurl='https://images-na.ssl-images-amazon.com/images/I/71S6oQqVa5L._SL1500_.jpg';
          if(messageText=='Potato')
            vegurl='https://cdn.britannica.com/s:900x675/89/170689-131-D20F8F0A/Potatoes.jpg';
          if(messageText=='Tomato')
            vegurl='https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/articles/health_tools/tomato_health_benefits_slideshow/493ss_thinkstock_rf_tomatoes_ripening_on_the_vine.jpg';
          if(messageText=='Onion')
            vegurl='https://images.indianexpress.com/2019/12/Onion-alternative_759.jpg';
          if (messageText=='Capsicum')
            vegurl='https://www.bazaarfresh.in/wp-content/uploads/2017/01/green-capsicum-500x500.png';
          if(messageText=='Beans')
            vegurl='https://gbc-cdn-public-media.azureedge.net/img83268.1426x713.jpg';
          if(messageText=='Raddish')
            vegurl='https://sabziwala.co.in/shoponline/image/cache/data/Vegetables/228x228/Raddish228x228-228x228.jpg';
          if(messageText=='DrumStick')
            vegurl='https://5.imimg.com/data5/TK/CU/MY-30646294/organic-drumstick-vegetable-500x500.jpg';
          if(messageText=='Bottleguard')
            vegurl='https://farmavo.in/wp-content/uploads/2020/01/Bottle-Guard-1-1.jpg';
          if(messageText=='Brinjal')
            vegurl='https://4.imimg.com/data4/RR/RR/GLADMIN-/wp-content-uploads-2016-04-brinjal-long-violet-500x500-400x400-500x500.jpg';
          if(messageText=='Peas')
            vegurl='https://images-na.ssl-images-amazon.com/images/I/51q4Qj0gHeL._SL1000_.jpg';
          if(messageText=='Cauliflower')
            vegurl='https://images-na.ssl-images-amazon.com/images/I/51k6xhLW5sL._SX466_.jpg';
          if(messageText=='Cabbage')
            vegurl='https://images.heb.com/is/image/HEBGrocery/000374791';
          if(messageText=='Beetroot')
            vegurl='https://images-na.ssl-images-amazon.com/images/I/616PXhYj8iL._SL1000_.jpg';







          final messageWidget =MessageBubble(
            sender: messageSender,
            text: messageText,
            price:messageprice,
            count:messagecount,

            isMe:currentuser==messageSender,
            vegurl1: vegurl,
            id: id,


          );



          if(currentuser==messageSender)
          messageWidgets.add(messageWidget);
        }
        /* return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),

            children: messageWidgets,
          ),
        );*/
        return Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: messageWidgets,

          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender,this.text,this.price,this.count,this.isMe,this.vegurl1,this.id});
  final String sender;
  final String text;
  final String price;
  final String count;
  final bool isMe;
  String id;


  String vegurl1;

  @override
  Widget build(BuildContext context) {


    return Padding(
    padding: EdgeInsets.all(10.0),

    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget>[
    Center(
      child: RaisedButton(
      onPressed:(){
        Bottombutton();
        _firestore.collection('cart').document(id).delete();

        var add = _firestore.collection('messages').add({
          'text': text,
          'sender': sender,
          'price': price,
          'count': count,
        }
        );

        showDialog(context: context,
            builder:(BuildContext context) =>CupertinoAlertDialog(
              title: Text('Alert'),
              content:Text('Data has been Deleted from your Cart'),
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

      },

      child:Text(
      'delete from cart',
      style: TextStyle(
      fontWeight: FontWeight.bold
      ),
      )),
    ),
    Expanded(

    child: Center(
    child: Image(
    image:NetworkImage(vegurl1),
    ),
    ),
    ),
    Center(
    child: Material(
    color: Colors.white70,
    elevation: 7.0,
    borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),
    bottomRight: Radius.circular(30.0),
    bottomLeft: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
    child: Padding(
    padding:EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    child: Text('$text * $count',
    style:TextStyle(
    color:Colors.black,
    fontSize: 15.0,
    )),
    ),
    ),

    ),
    SizedBox(
    height:10.0
    ),

    Center(
    child: Text(
    'Price = ₹$price',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold

      ),
    ),
    ),


    ]),


    );

  }

  }

class Bottombutton extends StatelessWidget {
  var userprice=0;
  @override
  Widget build(BuildContext context) {
   return  StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('cart').snapshots(),
      builder: (context, snapshot) {
    if (!snapshot.hasData) {
    return Center(
    child: CircularProgressIndicator(
    backgroundColor: Colors.blue,
    ));
    }

    final messages = snapshot.data.documents.reversed;
    List<MessageBubble> messageWidgets = [];
    for (var message in messages) {
    final messageText = message.data['veggie'];
    final messageSender = message.data['sender'];
    final messageprice=message.data['price'];
    final messagecount =message.data['count'];
    final currentuser=loggedinUser.email;

    if(currentuser==messageSender)
            {
userprice+= int.parse(messageprice)*int.parse(messagecount);
print(userprice);
            }

    }
    /* return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 15.0),

            children: messageWidgets,
          ),
        );*/
    return GestureDetector(
    onTap: (){


      Navigator.pushNamed(context,'/sixth');
    },
    child: Container(
    color: Colors.blue,
    margin: EdgeInsets.only(top: 10.0),
    width: double.infinity,
    height:70.0 ,
    child: Center(
    child: Text(
    'Pay ₹$userprice for checkout',
    style:TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15.0,
    )
    ),
    ),
    ),
    );
    },
   );
  }
}

