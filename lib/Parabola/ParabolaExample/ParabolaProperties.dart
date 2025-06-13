import 'package:flutter/material.dart';

class ParabolaFromPropertiesScreen extends StatelessWidget {
  const ParabolaFromPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parabola Properties')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertiesExample(equation: '(y - 1)² = -8(x + 2)', properties: [_buildProperty('Opening', 'To the left'), _buildProperty('Vertex', '(-2, 1)'), _buildProperty('Focus', '(-4, 1)'), _buildProperty('Directrix', 'x = 0'), _buildProperty('Axis of Symmetry', 'y = 1'), _buildProperty('Latus Rectum', '8 units'), _buildProperty('Endpoints', '(-4, 5) and (-4, -3)')], graphImage: 'assets/parabola_graph1.jpg'),
            const SizedBox(height: 24),
            _buildPropertiesExample(equation: 'y = 2x² - 4x + 3 → (x - 1)² = ½(y - 1)', properties: [_buildProperty('Opening', 'Upward'), _buildProperty('Vertex', '(1, 1)'), _buildProperty('Focus', '(1, 9/8)'), _buildProperty('Directrix', 'y = 7/8'), _buildProperty('Axis of Symmetry', 'x = 1'), _buildProperty('Latus Rectum', '½ unit'), _buildProperty('Endpoints', '(5/4, 9/8) and (3/4, 9/8)')], graphImage: 'assets/parabola_graph2.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertiesExample({required String equation, required List<Widget> properties, String? graphImage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Equation: $equation', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...properties,
        if (graphImage != null) ...[const SizedBox(height: 8), Image.asset(graphImage, width: 200, height: 200, fit: BoxFit.contain)],
      ],
    );
  }

  Widget _buildProperty(String name, String value) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 120, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))), const Text(': '), Expanded(child: Text(value))]));
  }
}
