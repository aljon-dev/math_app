import 'package:flutter/material.dart';
import 'package:math_app/Cone.dart';

class CurvesIntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cone-Nic', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.amber)),
              Text('CURVES', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue[900])),
              SizedBox(height: 20),
              Image.asset('assets/images/image1.png', height: 250),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.lightBlue, padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ConicSectionVisualization()));
                },
                child: Text('TRY IT!', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
