import 'package:flutter/material.dart';
import 'package:math_app/Circle/Examples/BasicFormulas.dart';
import 'package:math_app/Circle/Examples/CircleEquation.dart';
import 'package:math_app/Circle/Examples/DistanceMidpoint.dart';
import 'package:math_app/Circle/Examples/GraphicCircle.dart';
import 'package:math_app/Circle/Examples/RealWorld.dart';
import 'package:math_app/Circle/Examples/RealifeApplication.dart';
import 'package:math_app/Circle/Examples/Standartform.dart';

class CircleExamplesApp extends StatelessWidget {
  const CircleExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Circle Examples')), body: ListView(children: [_buildSectionCard(context, 'Real-life Applications', Icons.public, Colors.blue, () => Navigator.push(context, MaterialPageRoute(builder: (context) => RealLifeApplicationsScreen()))), _buildSectionCard(context, 'Basic Circle Formulas', Icons.calculate, Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (context) => BasicFormulasScreen()))), _buildSectionCard(context, 'Standard Form of Circle', Icons.functions, Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (context) => StandardFormScreen()))), _buildSectionCard(context, 'Circle Equations', Icons.square_foot, Colors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (context) => CircleEquationsScreen()))), _buildSectionCard(context, 'Distance & Midpoint Formulas', Icons.straighten, Colors.red, () => Navigator.push(context, MaterialPageRoute(builder: (context) => DistanceMidpointScreen()))), _buildSectionCard(context, 'Graphing Circles', Icons.graphic_eq, Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (context) => GraphingCirclesScreen()))), _buildSectionCard(context, 'Real-world Problems', Icons.landscape, Colors.brown, () => Navigator.push(context, MaterialPageRoute(builder: (context) => RealWorldProblemsScreen())))]));
  }

  Widget _buildSectionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(margin: const EdgeInsets.all(8.0), elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap, child: Padding(padding: const EdgeInsets.all(16.0), child: Row(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, color: color)), const SizedBox(width: 16), Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black87, fontWeight: FontWeight.w600)), const Spacer(), const Icon(Icons.chevron_right, color: Colors.grey)]))));
  }
}
