import 'package:flutter/material.dart';

class HyperbolaFromGraphScreen extends StatelessWidget {
  const HyperbolaFromGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child: Scaffold(
      appBar: AppBar(title: const Text('Hyperbola Graphs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGraphExample(equation: 'x²/16 - y²/36 = 1', properties: ['Center: (0, 0)', 'Orientation: Horizontal', 'a = 4, b = 6', 'Vertices: (±4, 0)', 'Foci: (±√52, 0) ≈ (±7.21, 0)', 'Asymptotes: y = ±(6/4)x = ±(3/2)x', 'Transverse axis length: 2a = 8', 'Conjugate axis length: 2b = 12'], graphImage: 'assets/images/hyperbola_graph3.png'),
            const SizedBox(height: 24),
            _buildGraphExample(equation: '4y² - 49x² = 196 → y²/49 - x²/4 = 1', properties: ['Center: (0, 0)', 'Orientation: Vertical', 'a = 7, b = 2', 'Vertices: (0, ±7)', 'Foci: (0, ±√53) ≈ (0, ±7.28)', 'Asymptotes: y = ±(7/2)x', 'Transverse axis length: 2a = 14', 'Conjugate axis length: 2b = 4'], graphImage: 'assets/images/hyperbola_graph4.png'),
          ],
        ),
      ),
    ));
  }

  Widget _buildGraphExample({required String equation, required List<String> properties, String? graphImage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Equation: $equation', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...properties.map((prop) => Padding(padding: const EdgeInsets.symmetric(vertical: 2.0), child: Text(prop))).toList(),
        if (graphImage != null) ...[const SizedBox(height: 8), Image.asset(graphImage, width: 200, height: 200, fit: BoxFit.contain)],
      ],
    );
  }
}
