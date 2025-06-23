import 'package:flutter/material.dart';

class ParabolaFromGraphScreen extends StatelessWidget {
  const ParabolaFromGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parabola Graphs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGraphExample(problem: '1. Find the standard equation of this graph:', solution: ['Vertex at (3, 0)', 'Focus at (6, 0)', 'Endpoints at (6, ±6)', 'Opens to the right → (y - k)² = 4p(x - h)', '4p = 12 (length of latus rectum)', 'Equation: y² = 12(x - 3)'], graphImage: 'assets/parabola_graph5.jpg'),
            const SizedBox(height: 24),
            _buildGraphExample(problem: '2. Find the standard equation of this graph:', solution: ['Vertex at (2, 2)', 'Focus at (2, 0)', 'Endpoints at (0, -2) and (0, 6)', 'Opens downward → (x - h)² = -4p(y - k)', '4p = 8 (length of latus rectum)', 'Equation: (x - 2)² = -8(y - 2)'], graphImage: 'assets/parabola_graph4.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphExample({required String problem, required List<String> solution, String? graphImage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(problem, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        if (graphImage != null) ...[const SizedBox(height: 8), Image.asset(graphImage, width: 200, height: 200, fit: BoxFit.contain)],
        const SizedBox(height: 8),
        const Text('Solution:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...solution.map((step) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text('• $step'))).toList(),
      ],
    );
  }
}
