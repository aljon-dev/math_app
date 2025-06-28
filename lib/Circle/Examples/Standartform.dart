import 'package:flutter/material.dart';

class StandardFormScreen extends StatelessWidget {
  const StandardFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Standard Form of Circle')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDerivationCard(context),
              const SizedBox(height: 20),
              _buildConversionCard(
                context,
                'General to Standard Form',
                'x² + y² + 6x - 4y - 3 = 0',
                '1. Group x and y terms: x² + 6x + y² - 4y = 3\n'
                    '2. Complete the square:\n'
                    '   For x: (6/2)² = 9\n'
                    '   For y: (-4/2)² = 4\n'
                    '3. Add to both sides: x² + 6x + 9 + y² - 4y + 4 = 3 + 9 + 4\n'
                    '4. Rewrite: (x + 3)² + (y - 2)² = 16\n'
                    '5. Final form: (x + 3)² + (y - 2)² = 4²',
              ),
              const SizedBox(height: 20),
              _buildConversionCard(
                context,
                'Standard to General Form',
                '(x + 4)² + (y - 1)² = 7²',
                '1. Expand squared terms:\n'
                    '   (x + 4)(x + 4) + (y - 1)(y - 1) = 49\n'
                    '2. Multiply: x² + 8x + 16 + y² - 2y + 1 = 49\n'
                    '3. Combine like terms: x² + y² + 8x - 2y + 17 = 49\n'
                    '4. Final form: x² + y² + 8x - 2y - 32 = 0',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDerivationCard(BuildContext context) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Deriving the Standard Form', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.orange[800])), const SizedBox(height: 12), const Text('Using the distance formula with points (h,k), (x,y) and distance r:', style: TextStyle(fontSize: 16)), const SizedBox(height: 8), _buildMathFormula(r'd = √ {(x_2 - x_1)^2 + (y_2 - y_1)^2}'), const SizedBox(height: 8), const Text('Substitute values:'), _buildMathFormula(r'r = √ {(x - h)^2 + (y - k)^2}'), const SizedBox(height: 8), const Text('Square both sides:'), _buildMathFormula(r'r^2 = (x - h)^2 + (y - k)^2'), _buildMathFormula(r'(x - h)^2 + (y - k)^2 = r^2'), const SizedBox(height: 8), const Text('For center at (0,0):'), _buildMathFormula(r'r^2 = x^2 + y^2')])));
  }

  Widget _buildConversionCard(BuildContext context, String title, String example, String steps) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.orange[700])), const SizedBox(height: 12), Text('Example: $example', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)), const SizedBox(height: 12), Text('Steps:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(steps, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }

  Widget _buildMathFormula(String tex) {
    return Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)), child: Text(tex, style: const TextStyle(fontSize: 18, fontFamily: 'RobotoMono')));
  }
}
