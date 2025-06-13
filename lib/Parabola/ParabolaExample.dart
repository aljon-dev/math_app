import 'package:flutter/material.dart';
import 'package:math_app/Parabola/ParabolaExample/ParabolaConversionScreen.dart';
import 'package:math_app/Parabola/ParabolaExample/ParabolaGraph.dart';
import 'package:math_app/Parabola/ParabolaExample/ParabolaIntroScreen.dart';
import 'package:math_app/Parabola/ParabolaExample/ParabolaProperties.dart';
import 'package:math_app/Parabola/ParabolaExample/RealwordParabola.dart';

class ParabolaExamplesApp extends StatelessWidget {
  const ParabolaExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Parabola Examples')), body: ListView(children: [_buildSectionCard(context, 'Real-life Examples', Icons.public, Colors.indigo, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ParabolaIntroScreen()))), _buildSectionCard(context, 'Equation Conversions', Icons.swap_horiz, Colors.teal, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ParabolaConversionsScreen()))), _buildSectionCard(context, 'From Properties', Icons.tune, Colors.orange, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ParabolaFromPropertiesScreen()))), _buildSectionCard(context, 'From Graphs', Icons.graphic_eq, Colors.purple, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ParabolaFromGraphScreen()))), _buildSectionCard(context, 'Real-world Problems', Icons.architecture, Colors.green, () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ParabolaRealWorldScreen())))]));
  }

  Widget _buildSectionCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(margin: const EdgeInsets.all(8.0), elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: InkWell(borderRadius: BorderRadius.circular(12), onTap: onTap, child: Padding(padding: const EdgeInsets.all(16.0), child: Row(children: [Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle), child: Icon(icon, color: color)), const SizedBox(width: 16), Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black87, fontWeight: FontWeight.w600)), const Spacer(), const Icon(Icons.chevron_right, color: Colors.grey)]))));
  }
}
