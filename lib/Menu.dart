import 'package:flutter/material.dart';
import 'package:math_app/DynamicShapes.dart';
import 'package:math_app/GeneralQuiz.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Shapes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)), actions: []),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top content that can scroll if needed
            Expanded(child: SingleChildScrollView(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Text('Select Shapes', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)), Padding(padding: EdgeInsets.fromLTRB(50, 0, 0, 0), child: Image.asset('assets/images/Conic_Sections_Shapes.png')), const SizedBox(height: 20), ButtonMenu(context, Colors.red, 'Circle', Icons.circle), const SizedBox(height: 15), ButtonMenu(context, Colors.orange, 'Ellipse', Icons.egg_alt), const SizedBox(height: 15), ButtonMenu(context, Colors.green, 'Parabola', Icons.stacked_line_chart), const SizedBox(height: 15), ButtonMenu(context, Colors.blue, 'Hyperbola', Icons.all_inclusive)]))),
            // Bottom button that stays at bottom
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ConicSectionsQuiz()));
                },
                icon: const Icon(Icons.quiz),
                label: const Text('General Quiz', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.orange, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.black, width: 2))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ButtonMenu(BuildContext context, Color color, String menuTitle, IconData iconData) {
    return SizedBox(
      height: 70,
      width: 250,
      child: ElevatedButton(
        onPressed: () {
          if (menuTitle == 'Circle') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 0.0, horizontalRotation: 0.0, verticalPosition: 0.0)));
          }
          if (menuTitle == 'Ellipse') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 0.5, horizontalRotation: 0.5, verticalPosition: 0.5)));
          }

          if (menuTitle == 'Parabola') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 0.7, horizontalRotation: 0.7, verticalPosition: 0.7)));
          }

          if (menuTitle == 'Hyperbola') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 1.2, horizontalRotation: 1.0, verticalPosition: 0.2)));
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.black, width: 2)), padding: const EdgeInsets.symmetric(horizontal: 10)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(iconData, size: 32), const SizedBox(width: 15), Text(menuTitle, style: const TextStyle(fontSize: 20))]),
      ),
    );
  }
}
