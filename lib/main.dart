import 'package:flash_chat/Feedbackuser.dart';
import 'package:flash_chat/screens/Cart.dart';
import 'package:flash_chat/screens/Pay.dart';
import 'package:flash_chat/screens/Profile.dart';
import 'package:flash_chat/screens/welcome1.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/farmerpage.dart';
import 'package:flash_chat/screens/Profile.dart';


void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      initialRoute: '/-1',
      routes: {
        '/-1': (context) => Welcome(),
        '/': (context) => WelcomeScreen(),
        '/first': (context) => LoginScreen(),
        '/second': (context) => RegistrationScreen(),
        '/third': (context) => ChatScreen(),
        '/fourth': (context) => Farmerpage1(),
        '/fifth': (context) => Cart(),
        '/sixth': (context) => Pay(),
        '/seventh': (context) => Feedbackuser(),


      },
    );
  }
}
