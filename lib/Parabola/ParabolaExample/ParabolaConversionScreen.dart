import 'package:flutter/material.dart';

class ParabolaConversionsScreen extends StatelessWidget {
  const ParabolaConversionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parabola Equation Conversions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConversionSection(
              title: 'Transform General Form to Standard Equation',
              examples: [
                _buildConversionExample(problem: '1. Convert: x² + 8x - 4y - 12 = 0', steps: ['Move the y-term: x² + 8x = 4y + 12', 'Complete the square: x² + 8x + 16 = 4y + 12 + 16', 'Simplify: (x + 4)² = 4y + 28', 'Factor: (x + 4)² = 4(y + 7)'], answer: 'Standard Form: (x + 4)² = 4(y + 7)'),
                _buildConversionExample(problem: '2. Convert: y² - 6y - 2x + 5 = 0', steps: ['Move the x-term: y² - 6y = 2x - 5', 'Complete the square: y² - 6y + 9 = 2x - 5 + 9', 'Simplify: (y - 3)² = 2x + 4', 'Factor: (y - 3)² = 2(x + 2)'], answer: 'Standard Form: (y - 3)² = 2(x + 2)'),
              ],
            ),
            const SizedBox(height: 24),
            _buildConversionSection(
              title: 'Transform Standard Equation to General Form',
              examples: [
                _buildConversionExample(problem: '1. Convert: (x - 3)² = 12(y + 2)', steps: ['Expand: x² - 6x + 9 = 12y + 24', 'Rearrange: x² - 6x - 12y - 15 = 0'], answer: 'General Form: x² - 6x - 12y - 15 = 0'),
                _buildConversionExample(problem: '2. Convert: (y - 2)² = 6(x + 4)', steps: ['Expand: y² - 4y + 4 = 6x + 24', 'Rearrange: y² - 4y - 6x - 20 = 0'], answer: 'General Form: y² - 4y - 6x - 20 = 0'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionSection({required String title, required List<Widget> examples}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), ...examples]);
  }

  Widget _buildConversionExample({required String problem, required List<String> steps, required String answer}) {
    return Card(margin: const EdgeInsets.symmetric(vertical: 8.0), child: Padding(padding: const EdgeInsets.all(12.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(problem, style: const TextStyle(fontWeight: FontWeight.bold)), const SizedBox(height: 8), ...steps.map((step) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text('• $step'))).toList(), const SizedBox(height: 8), Text(answer, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue))])));
  }
}
