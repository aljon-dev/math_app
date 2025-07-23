import 'package:flutter/material.dart';

class ParabolaIntroScreen extends StatelessWidget {
  const ParabolaIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child: Scaffold(appBar: AppBar(title: const Text('Real-life Examples of Parabola')), body: SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const SizedBox(height: 16), _buildExampleItem('Satellite Dish', '1. A parabola is a curved shape where every point is equidistant from a point called the focus and a line known as the directrix. In a satellite dish, this shape helps collect signals by reflecting them to one spot - the focus - where the receiver picks them up.', 'assets/parabola_satellite.jpg'), const SizedBox(height: 16), _buildExampleItem('Suspension Bridge', '2. The main cable on a suspension bridge (like the Golden Gate Bridge) hangs in a parabolic shape under the force of gravity. It\'s not a random curve - it\'s a perfect example of a parabola.', 'assets/parabola_bridge.jpg'), const SizedBox(height: 16), _buildExampleItem('Roller Coaster', '3. The high arcs of some roller coasters, particularly the older or simpler ones, create a parabolic shape as the coaster goes up and comes back down, following the path of gravity.', 'assets/parabola_rollercoaster.jpg')]))));
  }

  Widget _buildExampleItem(String title, String text, String imagePath) {
    return Card(elevation: 4, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(text, style: const TextStyle(fontSize: 16)), const SizedBox(height: 12), ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(imagePath, width: double.infinity, height: 200, fit: BoxFit.cover))])));
  }
}
