import 'package:flash_chat/screens/farmerpage.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Cart.dart';
import 'Profile.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedinUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textmessagecontroller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  String messagetext;

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

  /* void getMessages() async
  {
    final messages =await _firestore.collection('messages').getDocuments();
    for(var message in messages.documents ){
      print(message.data);
    }
  }*/

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          Tooltip(
            message: 'Go to cart',
            child: IconButton(
              icon: Icon(
                Icons.local_grocery_store,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/fifth');
              },
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.blueGrey,
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);

                //Implement logout functionality
              }),
        ],
        title: Hero(
          tag: 'head',
          child: Text(
            '🛒Agrocom',
            style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
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
                                'https://t4.ftcdn.net/jpg/00/87/28/19/240_F_87281963_29bnkFXa6RQnJYWeRfrSpieagNxw1Rru.jpg')));
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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),

          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  String vegurl;
  String id;
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
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
          id = message.documentID;
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageprice = message.data['price'];
          final messagecount = message.data['count'];
          final currentuser = loggedinUser.email;

          if (messageText == 'Carrot')
            vegurl =
                'https://images-na.ssl-images-amazon.com/images/I/71S6oQqVa5L._SL1500_.jpg';
          if (messageText == 'Potato')
            vegurl =
                'https://cdn.britannica.com/s:900x675/89/170689-131-D20F8F0A/Potatoes.jpg';
          if (messageText == 'Tomato')
            vegurl =
                'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/articles/health_tools/tomato_health_benefits_slideshow/493ss_thinkstock_rf_tomatoes_ripening_on_the_vine.jpg';
          if (messageText == 'Onion')
            vegurl =
                'https://images.indianexpress.com/2019/12/Onion-alternative_759.jpg';
          if (messageText == 'Capsicum')
            vegurl =
                'https://www.bazaarfresh.in/wp-content/uploads/2017/01/green-capsicum-500x500.png';
          if (messageText == 'Beans')
            vegurl =
                'https://gbc-cdn-public-media.azureedge.net/img83268.1426x713.jpg';
          if (messageText == 'Raddish')
            vegurl =
                'https://sabziwala.co.in/shoponline/image/cache/data/Vegetables/228x228/Raddish228x228-228x228.jpg';
          if (messageText == 'DrumStick')
            vegurl =
                'https://5.imimg.com/data5/TK/CU/MY-30646294/organic-drumstick-vegetable-500x500.jpg';
          if (messageText == 'Bottleguard')
            vegurl =
                'https://farmavo.in/wp-content/uploads/2020/01/Bottle-Guard-1-1.jpg';
          if (messageText == 'Brinjal')
            vegurl =
                'https://4.imimg.com/data4/RR/RR/GLADMIN-/wp-content-uploads-2016-04-brinjal-long-violet-500x500-400x400-500x500.jpg';
          if (messageText == 'Peas')
            vegurl =
                'https://images-na.ssl-images-amazon.com/images/I/51q4Qj0gHeL._SL1000_.jpg';
          if (messageText == 'Cauliflower')
            vegurl =
                'https://images-na.ssl-images-amazon.com/images/I/51k6xhLW5sL._SX466_.jpg';
          if (messageText == 'Cabbage')
            vegurl = 'https://images.heb.com/is/image/HEBGrocery/000374791';
          if (messageText == 'Beetroot')
            vegurl =
                'https://images-na.ssl-images-amazon.com/images/I/616PXhYj8iL._SL1000_.jpg';

          if (messagecount != '0') {
            final messageWidget = MessageBubble(
              sender: messageSender,
              text: messageText,
              price: messageprice,
              count: messagecount,
              vegurl1: vegurl,
              isMe: currentuser == messageSender,
            );

            messageWidgets.add(messageWidget);
          }
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
  MessageBubble(
      {this.sender,
      this.text,
      this.price,
      this.count,
      this.vegurl1,
      this.isMe});
  final String sender;
  final String text;
  final String price;
  final String count;
  final bool isMe;
  String id;
  String vegurl1;
  String units;

  void calc(units) {
    print(units);
    if(units!="" && units!=null) {
      _firestore.collection('cart').add(
        {
          'veggie': text,
          'count': units,
          'price': price,
          'sender': loggedinUser.email,
        },
      );
    }
    var a = (int.parse(count) - int.parse(units));
    String b = a.toString();
    var add = _firestore.collection('messages').add({
      'text': text,
      'sender': sender,
      'price': price,
      'count': b,
    });
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('enter no of units less than $count '),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Add to cart'),
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
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
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageprice = message.data['price'];
          final messagecount = message.data['count'];
          final currentuser = loggedinUser.email;

          if (messageText == text) {
            id = message.documentID;
          }
        }
        return Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      sender,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12.0,
                      ),
                    ),
                    Expanded(
                      child: Tooltip(
                        message: 'Add to cart',
                        child: FlatButton(
                          child: Icon(
                            Icons.local_grocery_store,
                            size: 30.0,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            createAlertDialog(context).then((onvalue) {
                              SnackBar mySnackbar = SnackBar(
                                  content: Text(
                                      '$onvalue units of  $text added to cart'));
                              calc(onvalue);
                              Scaffold.of(context).showSnackBar(mySnackbar);

                              _firestore
                                  .collection('messages')
                                  .document(id)
                                  .delete();
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                /* SizedBox(
        height: 30.0,
      ),*/
                Expanded(
                  child: Center(
                    child: Image(
                      image: NetworkImage(vegurl1),
                    ),
                  ),
                ),
                Center(
                  child: Material(
                    color: Colors.white70,
                    elevation: 7.0,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                        bottomLeft: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text('$text * $count',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                          )),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
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
        ;
      },
    );
  }
}
