import 'package:flutter/material.dart';

class HyperbolaRealWorldScreen extends StatelessWidget {
  const HyperbolaRealWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child: Scaffold(
      appBar: AppBar(title: const Text('Real-world Hyperbola Problems')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProblem(problem: '1. A cooling tower is shaped like a hyperbola that can be modeled by x²/25 - y²/256 = 1. What is the width of the tower at its narrowest part in the middle?', solution: ['Given: a² = 25 → a = 5', 'The narrowest part is the length of the transverse axis: 2a', 'Solution: 2(5) = 10', 'Answer: The narrowest part is 10 meters.'], image: 'assets/images/hyperbola_cooling_tower_problem.png'),
            const SizedBox(height: 24),
            _buildProblem(problem: '2. A cooling tower stands 195 meters tall. The diameter of the top is 82 meters. At their closest, the sides are 50 meters apart. Find the equation of the hyperbola that models the sides.', solution: ['Given:', '2a = 50 → a = 25 → a² = 625', 'Top radius = 82/2 = 41m', 'Height to top = 95m (from center)', 'Using point (41, 95) on hyperbola:', 'b² = y² / (x²/a² - 1) = 95² / (41²/25² - 1) ≈ 5341.50', 'Final equation: x²/625 - y²/5341.50 = 1'], image: 'assets/images/hyperbola_cooling_tower_equation.png'),
          ],
        ),
      ),
    ));
  }

  Widget _buildProblem({required String problem, required List<String> solution, String? image}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(problem, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (image != null) ...[Image.asset(image, width: 300, height: 150, fit: BoxFit.cover), const SizedBox(height: 8)],
        const Text('Solution:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...solution.map((step) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text(step))).toList(),
      ],
    );
  }
}
