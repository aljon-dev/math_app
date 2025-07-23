import 'package:flutter/material.dart';
import 'package:math_app/Cone.dart';
import 'package:math_app/DynamicShapes.dart';
import 'package:math_app/GeneralQuiz.dart';
import 'package:math_app/main.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({Key? key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConicSectionVisualization()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ConicSectionVisualization()));
            },
          ),
          centerTitle: true,
          title: const Text('Menu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          actions: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyApp()));
              },
              icon: const Icon(Icons.home, size: 30),
              label: const Text(''),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundmenu.jpg'), // Add your background image here
                fit: BoxFit.cover, // You can change this to BoxFit.fill, BoxFit.contain, etc.
                // Adjust opacity so content remains readable (0.0 to 1.0)
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                // Top content that can scroll if needed
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 200),

                        ButtonMenu(context, Colors.red, 'Circle', Icons.circle),
                        const SizedBox(height: 15),
                        ButtonMenu(context, Colors.orange, 'Ellipse', Icons.egg_alt),
                        const SizedBox(height: 15),
                        ButtonMenu(context, Colors.green, 'Parabola', Icons.stacked_line_chart),
                        const SizedBox(height: 15),
                        ButtonMenu(context, Colors.blue, 'Hyperbola', Icons.all_inclusive),
                        const SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ConicSectionsQuiz()));
                            },
                            icon: const Icon(Icons.quiz),
                            label: const Text('General Quiz', style: TextStyle(fontSize: 18)),
                            style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: const Color.fromARGB(255, 51, 1, 54), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.black, width: 2))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Bottom button that stays at bottom
              ],
            ),
          ),
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
          switch (menuTitle) {
            case 'Circle':
              Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 0.05, horizontalRotation: 0.0, verticalPosition: 0.5)));
              break;
            case 'Ellipse':
              Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 0.5, horizontalRotation: 0.5, verticalPosition: 0.5)));
              break;
            case 'Parabola':
              Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 1.1, horizontalRotation: 0.7, verticalPosition: 0.7)));
              break;
            case 'Hyperbola':
              Navigator.push(context, MaterialPageRoute(builder: (context) => DynamicShapes(planeAngle: 1.3, horizontalRotation: 1.0, verticalPosition: 0.2)));
              break;
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.black, width: 2)), padding: const EdgeInsets.symmetric(horizontal: 10)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(iconData, size: 32), const SizedBox(width: 15), Text(menuTitle, style: const TextStyle(fontSize: 20))]),
      ),
    );
  }
}
