import 'package:flutter/material.dart';
import 'package:math_app/Cone.dart';

class CurvesIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image - fullscreen
          Container(width: double.infinity, height: double.infinity, child: Image.asset('assets/introbackground.jpg', fit: BoxFit.fill)),

          // Button positioned at bottom
          Positioned(
            bottom: 80,
            left: 105,
            right: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ConicSectionVisualization()));
              },
              child: Text('Try it', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
