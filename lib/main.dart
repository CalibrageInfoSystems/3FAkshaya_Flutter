import 'package:flutter/material.dart';
import 'package:akshayaflutter/Splash_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),

      debugShowCheckedModeBanner: false,// Set SplashScreen as the initial route

    );
  }
}
