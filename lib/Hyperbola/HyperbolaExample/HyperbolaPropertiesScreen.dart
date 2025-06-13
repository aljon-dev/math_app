import 'package:flutter/material.dart';

class HyperbolaFromPropertiesScreen extends StatelessWidget {
  const HyperbolaFromPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hyperbola Properties')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertiesExample(equation: '(x + 3)²/10 - (y - 1)²/45 = 1', properties: [_buildProperty('Center', '(h, k) = (-3, 1)'), _buildProperty('Orientation', 'Horizontal'), _buildProperty('a²', '10 → a = √10 ≈ 3.16'), _buildProperty('b²', '45 → b = √45 ≈ 6.71'), _buildProperty('c²', 'a² + b² = 55 → c = √55 ≈ 7.42'), _buildProperty('Vertices', '(-3 ± √10, 1) ≈ (0.16, 1), (-6.16, 1)'), _buildProperty('Foci', '(-3 ± √55, 1) ≈ (4.42, 1), (-10.42, 1)')], graphImage: 'assets/hyperbola_graph1.jpg'),
            const SizedBox(height: 24),
            _buildPropertiesExample(equation: '(y - 8)²/25 - (x - 4)²/16 = 1', properties: [_buildProperty('Center', '(h, k) = (4, 8)'), _buildProperty('Orientation', 'Vertical'), _buildProperty('a²', '25 → a = 5'), _buildProperty('b²', '16 → b = 4'), _buildProperty('c²', 'a² + b² = 41 → c = √41 ≈ 6.40'), _buildProperty('Vertices', '(4, 8 ± 5) = (4, 13), (4, 3)'), _buildProperty('Foci', '(4, 8 ± √41) ≈ (4, 14.40), (4, 1.60)'), _buildProperty('Asymptotes', 'y - 8 = ±(5/4)(x - 4)')], graphImage: 'assets/hyperbola_graph2.jpg'),
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
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 80, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))), const Text(': '), Expanded(child: Text(value))]));
  }
}
