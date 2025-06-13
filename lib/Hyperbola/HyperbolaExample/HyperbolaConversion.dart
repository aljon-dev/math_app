import 'package:flutter/material.dart';

class HyperbolaConversionsScreen extends StatelessWidget {
  const HyperbolaConversionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hyperbola Equation Conversions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConversionExample(title: '1. Transform General form to standard equation', problem: 'Write the standard form of Hyperbola: 9x² - 2y² + 54x + 4y - 11 = 0', steps: ['1st: Group all the x\'s and all y\'s but start with positive x² or y²', '(9x² + 54x) - (2y² - 4y) = 11', '2nd: Factor out the coefficient of x² and y² then simplify', '9(x² + 6x) - 2(y² - 2y) = 11', '3rd: Completing the square', 'For x: (6/2)² = 9 | For y: (2/2)² = 1', '9(x² + 6x + 9) - 2(y² - 2y + 1) = 11 + 81 - 2', '4th: Factoring and simplify', '9(x + 3)² - 2(y - 1)² = 90', '5th: Equation must be equal to 1', '(x + 3)²/10 - (y - 1)²/45 = 1'], answer: 'Final Answer: (x + 3)²/10 - (y - 1)²/45 = 1', graphImage: 'assets/hyperbola_graph1.jpg'),
            const SizedBox(height: 24),
            _buildConversionExample(title: '2. Transform Standard form to General Form', problem: 'Transform: (y - 8)²/25 - (x - 4)²/16 = 1', steps: ['1st: Multiply by LCD (25)(16)', '16(y - 8)² - 25(x - 4)² = 400', '2nd: Expand the squared terms', '16(y² - 16y + 64) - 25(x² - 8x + 16) = 400', '3rd: Distribute', '16y² - 256y + 1024 - 25x² + 200x - 400 = 400', '4th: Arrange to General Form', '-25x² + 16y² + 200x - 256y + 224 = 0'], answer: 'Final Answer: -25x² + 16y² + 200x - 256y + 224 = 0', graphImage: 'assets/hyperbola_graph2.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionExample({required String title, required String problem, required List<String> steps, required String answer, String? graphImage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(problem, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...steps.map((step) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text(step))).toList(),
        const SizedBox(height: 8),
        Text(answer, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        if (graphImage != null) ...[const SizedBox(height: 8), Image.asset(graphImage, width: 200, height: 200, fit: BoxFit.contain)],
      ],
    );
  }
}
