import 'package:fx_crystal_ball/screens/datain_screen.dart';
import 'package:flutter/material.dart';
import 'package:fx_crystal_ball/screens/welcome_screen.dart';
import 'package:fx_crystal_ball/screens/login_screen.dart';
import 'package:fx_crystal_ball/screens/registration_screen.dart';
import 'package:fx_crystal_ball/screens/chat_screen.dart';
import 'package:fx_crystal_ball/calc/pages/exchange_screen.dart';

void main() => runApp(FXCrystalBall());

class FXCrystalBall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        UserInput.id: (context) => UserInput(),
        ExchangeScreen.id: (context) => ExchangeScreen(),
      },
    );
  }
}
