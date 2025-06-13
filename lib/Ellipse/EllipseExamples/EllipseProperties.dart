import 'package:flutter/material.dart';

class EllipseFromPropertiesScreen extends StatelessWidget {
  const EllipseFromPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ellipse from Properties')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPropertyCard(
              context,
              'Example 1',
              'Given: Major axis = 20, Foci = (0,5) and (0,-5)',
              '1. Major axis vertical ⇒ y-axis form\n'
                  '2. 2a = 20 ⇒ a = 10, a² = 100\n'
                  '3. c = 5 ⇒ c² = 25\n'
                  '4. b² = a² - c² = 100 - 25 = 75\n'
                  '5. Equation: x²/75 + y²/100 = 1',
            ),
            const SizedBox(height: 20),
            _buildPropertyCard(
              context,
              'Example 2',
              'Given: Vertices = (±8,0), Foci = (±5,0)',
              '1. Major axis horizontal ⇒ x-axis form\n'
                  '2. a = 8 ⇒ a² = 64\n'
                  '3. c = 5 ⇒ c² = 25\n'
                  '4. b² = a² - c² = 64 - 25 = 39\n'
                  '5. Equation: x²/64 + y²/39 = 1',
            ),
            const SizedBox(height: 20),
            _buildPropertyCard(
              context,
              'Example 3',
              'Given: Vertices = (-2,-8) and (-2,2), Foci = (-2,-7) and (-2,1)',
              '1. Major axis vertical ⇒ y-axis form\n'
                  '2. Center = midpoint = (-2,-3)\n'
                  '3. 2a = 10 ⇒ a = 5, a² = 25\n'
                  '4. c = 4 ⇒ c² = 16\n'
                  '5. b² = a² - c² = 25 - 16 = 9\n'
                  '6. Equation: (x+2)²/9 + (y+3)²/25 = 1',
            ),
            const SizedBox(height: 20),
            _buildPropertyCard(
              context,
              'Example 4',
              'Given: Center = (7,-2), Vertex = (2,-2), Minor endpoint = (7,-6)',
              '1. Major axis horizontal ⇒ x-axis form\n'
                  '2. a = 5 ⇒ a² = 25\n'
                  '3. b = 4 ⇒ b² = 16\n'
                  '4. Equation: (x-7)²/25 + (y+2)²/16 = 1',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, String title, String given, String solution) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.orange[800])), const SizedBox(height: 12), Text('Given: $given', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5)), const SizedBox(height: 12), Text('Solution:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(solution, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5))])));
  }
}
