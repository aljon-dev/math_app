import 'package:flutter/material.dart';

class EllipseRealWorldScreen extends StatelessWidget {
  const EllipseRealWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child: Scaffold(
      appBar: AppBar(title: const Text('Real-world Ellipse Problems')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProblemCard(
              context,
              'Swimming Pool Design',
              'An elliptical pool is 26m long and 12m wide, centered at origin.',
              '1. 2a = 26 ⇒ a = 13\n'
                  '2. 2b = 12 ⇒ b = 6\n'
                  '3. Horizontal ellipse ⇒ x²/a² + y²/b² = 1\n'
                  '4. Equation: x²/169 + y²/36 = 1',
              'assets/pool_design.jpg',
            ),
            const SizedBox(height: 20),
            _buildProblemCard(
              context,
              'Garden with Walkway',
              'Elliptical garden 24m long, 8m wide with 4m wide walkway.',
              '1. Original a = 12, b = 4\n'
                  '2. With walkway: a = 12+4 = 16, b = 4+4 = 8\n'
                  '3. Equation: x²/256 + y²/64 = 1',
              'assets/garden_walkway.jpg',
            ),
            const SizedBox(height: 20),
            _buildProblemCard(
              context,
              'Elliptical Tabletop',
              'Tabletop 180cm long, 100cm wide. Find distance between foci.',
              '1. 2a = 180 ⇒ a = 90\n'
                  '2. 2b = 100 ⇒ b = 50\n'
                  '3. c² = a² - b² = 8100 - 2500 = 5600\n'
                  '4. c ≈ 74.83 ⇒ Distance between foci ≈ 149.66cm',
              'assets/elliptical_table.jpg',
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildProblemCard(BuildContext context, String title, String problem, String solution, String imagePath) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.green[800])), const SizedBox(height: 12), Text(problem, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5)), const SizedBox(height: 12), Center(child: Image.asset(imagePath, width: 200, height: 150, fit: BoxFit.cover)), const SizedBox(height: 12), Text('Solution:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(solution, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }
}
