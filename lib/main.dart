import 'package:flutter/material.dart';
import 'package:math_app/Intro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'MathApp', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), home: WelcomeScreen());
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image - fullscreen
          Container(width: double.infinity, height: double.infinity, child: Image.asset('assets/background.jpg', fit: BoxFit.fill)),

          // Button positioned at bottom
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConicSectionIntroPage()));
              },
              child: Text('GET STARTED', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
