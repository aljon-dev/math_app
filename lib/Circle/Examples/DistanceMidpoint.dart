import 'package:flutter/material.dart';

class DistanceMidpointScreen extends StatelessWidget {
  const DistanceMidpointScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Distance & Midpoint Formulas')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExampleCard(
                context,
                'Finding Center from Diameter Endpoints',
                'Endpoints: (-5,6) and (3,-2)',
                '1. Use midpoint formula:\n'
                    '   M = ((x₁ + x₂)/2, (y₁ + y₂)/2)\n'
                    '2. Substitute values:\n'
                    '   M = ((-5 + 3)/2, (6 + (-2))/2)\n'
                    '   M = (-2/2, 4/2)\n'
                    '3. Center: (-1, 2)',
              ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Finding Radius from Endpoints',
                'Center: (-1,2), Endpoint: (3,-2)',
                '1. Use distance formula:\n'
                    '   d = √[(x₂ - x₁)² + (y₂ - y₁)²]\n'
                    '2. Substitute values:\n'
                    '   d = √[(3 - (-1))² + (-2 - 2)²]\n'
                    '   d = √[(4)² + (-4)²] = √[16 + 16] = √32\n'
                    '3. Simplify: 4√2\n'
                    '4. Radius: 4√2',
              ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Writing Equation from Diameter',
                'Endpoints: (-5,6) and (3,-2)',
                '1. Find center (midpoint): (-1,2)\n'
                    '2. Find radius (distance): 4√2\n'
                    '3. Write standard form:\n'
                    '   (x - (-1))² + (y - 2)² = (4√2)²\n'
                    '4. Simplify:\n'
                    '   (x + 1)² + (y - 2)² = 32',
              ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Finding Center from Diameter (Another Example)',
                'Endpoints: (-6,2) and (4,-8)',
                '1. Use midpoint formula:\n'
                    '   M = ((x₁ + x₂)/2, (y₁ + y₂)/2)\n'
                    '2. Substitute values:\n'
                    '   M = ((-6 + 4)/2, (2 + (-8))/2)\n'
                    '   M = (-2/2, -6/2)\n'
                    '3. Center: (-1, -3)',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, String title, String problem, String solution) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.red[800])), const SizedBox(height: 12), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)), child: Text(problem, style: const TextStyle(fontSize: 16, fontFamily: 'RobotoMono'))), const SizedBox(height: 12), Text('Solution:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(solution, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }
}
