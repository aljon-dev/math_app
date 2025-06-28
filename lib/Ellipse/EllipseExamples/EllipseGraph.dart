import 'package:flutter/material.dart';

class EllipseFromGraphScreen extends StatelessWidget {
  const EllipseFromGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child:  Scaffold(
      appBar: AppBar(title: const Text('Ellipse from Graphs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGraphExample(
              context,
              'Example 1',
              'Graph with center at (3,-1), a=3, b=2 (vertical)',
              '1. Identify center: (3,-1)\n'
                  '2. Identify a=3, b=2\n'
                  '3. Standard form: (x-3)²/4 + (y+1)²/9 = 1',
              'assets/ellipse_graph1.jpg',
            ),
            const SizedBox(height: 20),
            _buildGraphExample(
              context,
              'Example 2',
              'Graph with center at (-4,2), a=5, b=4 (horizontal)',
              '1. Identify center: (-4,2)\n'
                  '2. Identify a=5, b=4\n'
                  '3. Standard form: (x+4)²/25 + (y-2)²/16 = 1',
              'assets/ellipse_graph2.jpg',
            ),
            const SizedBox(height: 20),
            _buildGraphExample(
              context,
              'Find Coordinates (Example 1)',
              'Graph with center at (6,-4), vertices at (-3,-4) and (15,-4)',
              '1. Center: (6,-4)\n'
                  '2. Vertices: (-3,-4) and (15,-4)\n'
                  '3. Co-vertices: (6,1) and (6,-9)',
              'assets/ellipse_graph3.jpg',
            ),
            const SizedBox(height: 20),
            _buildGraphExample(
              context,
              'Find Coordinates (Example 2)',
              'Graph with center at (-4,7), vertices at (-4,17) and (-4,-3)',
              '1. Center: (-4,7)\n'
                  '2. Vertices: (-4,17) and (-4,-3)\n'
                  '3. Co-vertices: (-10,7) and (2,7)',
              'assets/ellipse_graph4.jpg',
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildGraphExample(BuildContext context, String title, String description, String solution, String imagePath) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.purple[800])), const SizedBox(height: 12), Text(description, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5)), const SizedBox(height: 12), Center(child: Image.asset(imagePath, width: 200, height: 200, fit: BoxFit.contain)), const SizedBox(height: 12), Text('Solution:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(solution, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }
}
