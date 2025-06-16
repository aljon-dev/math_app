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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 80),
              Column(children: [Text('Cone-Nic', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.amber)), Text('CURVES', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[900]))]),
              SizedBox(height: 5),
              Padding(padding: EdgeInsets.fromLTRB(50, 0, 0, 0), child: Image.asset('assets/images/Conic_Sections_Shapes.png', height: 300)),

              SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => IntroScreen()));
                },
                child: Text('GET STARTED', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
