import 'package:flutter/material.dart';

class EllipseConversionsScreen extends StatelessWidget {
  const EllipseConversionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ellipse Equation Conversions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConversionCard(
              context,
              'General to Standard Form (Example 1)',
              'x² + 5y² - 8x - 30y - 39 = 0',
              '1. Group x\'s and y\'s: x² - 8x + 5y² - 30y = 39\n'
                  '2. Complete the square:\n'
                  '   (x² - 8x + 16) + 5(y² - 6y + 9) = 39 + 16 + 45\n'
                  '3. Factor: (x - 4)² + 5(y - 3)² = 100\n'
                  '4. Divide by 100: \n'
                  '   (x - 4)²/100 + (y - 3)²/20 = 1',
            ),
            const SizedBox(height: 20),
            _buildConversionCard(
              context,
              'General to Standard Form (Example 2)',
              'x² + 4y² + 6x - 8y + 9 = 0',
              '1. Group terms: (x² + 6x) + 4(y² - 2y) = -9\n'
                  '2. Complete the square:\n'
                  '   (x² + 6x + 9) + 4(y² - 2y + 1) = -9 + 9 + 4\n'
                  '3. Factor: (x + 3)² + 4(y - 1)² = 4\n'
                  '4. Divide by 4: \n'
                  '   (x + 3)²/4 + (y - 1)²/1 = 1',
            ),
            const SizedBox(height: 20),
            _buildConversionCard(
              context,
              'Standard to General Form (Example 1)',
              'x²/25 + y²/9 = 1',
              '1. Find LCD: (9x² + 25y²)/225 = 1\n'
                  '2. Multiply: 9x² + 25y² = 225\n'
                  '3. General form: 9x² + 25y² - 225 = 0',
            ),
            const SizedBox(height: 20),
            _buildConversionCard(
              context,
              'Standard to General Form (Example 2)',
              '(x + 3)²/4 + y²/16 = 1',
              '1. Multiply by LCD 16: 4(x + 3)² + y² = 16\n'
                  '2. Expand: 4(x² + 6x + 9) + y² = 16\n'
                  '3. Simplify: 4x² + y² + 24x + 36 - 16 = 0\n'
                  '4. General form: 4x² + y² + 24x + 20 = 0',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionCard(BuildContext context, String title, String equation, String steps) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.teal[800])), const SizedBox(height: 12), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)), child: Text(equation, style: const TextStyle(fontSize: 18, fontFamily: 'RobotoMono'))), const SizedBox(height: 12), Text('Steps:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(steps, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }
}
