import 'package:flutter/material.dart';

class CircleEquationsScreen extends StatelessWidget {
  const CircleEquationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Circle Equations')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             _buildExampleCard(
                  context,
                  'Finding Center and Radius',
                  '(x + 2)² + (y - 1)² = 36',
                  '1. Use the standard form of the circle equation: (x - h)² + (y - k)² = r²\n'
                      '2. Determine the values of center (h, k) and radius r:\n'
                      '   (x - (-2))² + (y - 1)² = 6²\n'
                      '   Note: Always change the sign of the value inside parentheses\n'
                      '3. Take the square root of 36: √36 = 6\n'
                      '4. Center: (-2, 1), Radius: 6',
                ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Equation from Center and Radius (1)',
                'Center: (0,0), Radius: 5',
                '1. Use standard form: (x - h)² + (y - k)² = r²\n'
                    '2. Substitute values:\n'
                    '   (x - 0)² + (y - 0)² = 5²\n'
                    '3. Simplify:\n'
                    '   x² + y² = 25',
              ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Equation from Center and Radius (2)',
                'Center: (3,-4), Radius: 3',
                '1. Use standard form: (x - h)² + (y - k)² = r²\n'
                    '2. Substitute values:\n'
                    '   (x - 3)² + (y - (-4))² = 3²\n'
                    '3. Simplify:\n'
                    '   (x - 3)² + (y + 4)² = 9',
              ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Finding Center and Radius (Special Case)',
                '9x² + 9y² = 81',
                '1. Divide all terms by 9:\n'
                    '   x² + y² = 9\n'
                    '2. Compare with standard form:\n'
                    '   (x - 0)² + (y - 0)² = 3²\n'
                    '3. Center: (0,0), Radius: 3',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, String title, String problem, String solution) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.purple[800])), const SizedBox(height: 12), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)), child: Text(problem, style: const TextStyle(fontSize: 18, fontFamily: 'RobotoMono'))), const SizedBox(height: 12), Text('Solution:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(solution, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }
}
