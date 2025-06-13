import 'package:flutter/material.dart';

class BasicFormulasScreen extends StatelessWidget {
  const BasicFormulasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Basic Circle Formulas')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFormulaCard(
              context,
              'Area of the Circle',
              'A = πr²',
              'If the radius of the circle is 6 cm, what is the area?\n\n'
                  '1. Identify the radius: r = 6 cm\n'
                  '2. Square the radius: 6² = 36\n'
                  '3. Multiply by π: A = π × 36\n'
                  '4. Calculate: A ≈ 3.14159 × 36 ≈ 113.10 cm²',
            ),
            const SizedBox(height: 20),
            _buildFormulaCard(
              context,
              'Diameter of the Circle',
              'd = 2r',
              'If we have the radius of 6 cm, what is the diameter?\n\n'
                  '1. Using the formula: d = 2r\n'
                  '2. Substitute: d = 2 × 6\n'
                  '3. Calculate: d = 12 cm',
            ),
            const SizedBox(height: 20),
            _buildFormulaCard(
              context,
              'Circumference of the Circle',
              'C = 2πr',
              'Find the circumference if the radius is 6 cm\n\n'
                  '1. Using the formula: C = 2πr\n'
                  '2. Substitute: C = 2π × 6 = 12π\n'
                  '3. Calculate: C ≈ 12 × 3.14159 ≈ 37.70 cm',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormulaCard(BuildContext context, String title, String formula, String steps) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.green[800])), const SizedBox(height: 12), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)), child: Text(formula, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'RobotoMono'))), const SizedBox(height: 16), Text('Example:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(steps, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }
}
