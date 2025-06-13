import 'package:flutter/material.dart';

class GraphingCirclesScreen extends StatelessWidget {
  const GraphingCirclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Graphing Circles')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExampleCard(
              context,
              'Graphing from Equation (1)',
              '(x - 0)² + (y - 0)² = 3²',
              '1. Identify center: (0,0)\n'
                  '2. Identify radius: 3\n'
                  '3. Plot center at origin\n'
                  '4. Mark points 3 units up, down, left, right\n'
                  '5. Draw circle through these points',
              'assets/graph_example1.png',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Graphing from Equation (2)',
              'x² + (y - 2)² = 16',
              '1. Rewrite as: (x - 0)² + (y - 2)² = 4²\n'
                  '2. Identify center: (0,2)\n'
                  '3. Identify radius: 4\n'
                  '4. Plot center at (0,2)\n'
                  '5. Mark points 4 units in all directions\n'
                  '6. Draw circle through these points',
              'assets/graph_example2.png',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Writing Equation from Graph (1)',
              'Graph with center at (2,-1) and radius 2',
              '1. Identify center: (2,-1)\n'
                  '2. Measure radius: 2\n'
                  '3. Write standard form:\n'
                  '   (x - 2)² + (y - (-1))² = 2²\n'
                  '4. Simplify:\n'
                  '   (x - 2)² + (y + 1)² = 4',
              'assets/graph_example3.png',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Writing Equation from Graph (2)',
              'Graph with center at (0,0) and radius 3',
              '1. Identify center: (0,0)\n'
                  '2. Measure radius: 3\n'
                  '3. Write standard form:\n'
                  '   (x - 0)² + (y - 0)² = 3²\n'
                  '4. Simplify:\n'
                  '   x² + y² = 9',
              'assets/graph_example4.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, String title, String problem, String solution, String imagePath) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.teal[800])), const SizedBox(height: 12), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)), child: Text(problem, style: const TextStyle(fontSize: 16, fontFamily: 'RobotoMono'))), const SizedBox(height: 12), Text('Steps:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(solution, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5)), const SizedBox(height: 12), Center(child: Image.asset(imagePath, width: 250, height: 250, fit: BoxFit.contain))])));
  }
}
