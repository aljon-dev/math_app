import 'package:flutter/material.dart';

class ParabolaRealWorldScreen extends StatelessWidget {
  const ParabolaRealWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real-world Parabola Problems')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProblem(problem: '1. Given vertex at (1, 1), opens downward, and has a latus rectum length of 2 units. Find the equation.', solution: ['Standard form for downward parabola: (x - h)² = -4p(y - k)', 'Vertex (h, k) = (1, 1)', '4p = 2 → p = 0.5', 'Equation: (x - 1)² = -2(y - 1)']),
            const SizedBox(height: 24),
            _buildProblem(problem: '2. A bridge has a parabolic arch modeled by (x - 3)² = -8(y - 12). What is the maximum height?', solution: ['Equation is in standard form: (x - h)² = -4p(y - k)', 'Vertex (h, k) = (3, 12)', 'For downward parabola, vertex is the highest point', 'Maximum height = 12 meters'], image: 'assets/parabola_bridge_problem.jpg'),
          ],
        ),
      ),
    );
  }

  Widget _buildProblem({required String problem, required List<String> solution, String? image}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(problem, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            if (image != null) ...[const SizedBox(height: 8), Image.asset(image, width: 300, height: 150, fit: BoxFit.cover)],
            const SizedBox(height: 8),
            const Text('Solution:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...solution.map((step) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text('• $step'))).toList(),
          ],
        ),
      ),
    );
  }
}
