import 'package:flutter/material.dart';

class FormulasHyperbolaSection extends StatefulWidget {
  const FormulasHyperbolaSection({Key? key}) : super(key: key);

  @override
  State<FormulasHyperbolaSection> createState() => _FormulasHyperbolaSectionState();
}

class _FormulasHyperbolaSectionState extends State<FormulasHyperbolaSection> {
  int currentStep = 0;

  final List<Map<String, dynamic>> hyperbolaSteps = [
    {'title': 'FORMULAS OF THE HYPERBOLA', 'content': 'Learn about standard forms of hyperbolas, their orientation, key features like foci, vertices, co-vertices, asymptotes, and eccentricity.', 'image': 'assets/images/hyperbola_intro.png', 'type': 'intro'},
    {'title': 'Horizontal Hyperbola (Center at Origin)', 'content': 'Standard form: x²/a² - y²/b² = 1\n• Center: (0, 0)\n• Vertices: (±a, 0)\n• Co-Vertices: (0, ±b)\n• Foci: (±c, 0), where c² = a² + b²\n• Asymptotes: y = ±(b/a)x', 'image': 'assets/images/horizontal_origin.png', 'type': 'formula'},
    {'title': 'Vertical Hyperbola (Center at Origin)', 'content': 'Standard form: y²/a² - x²/b² = 1\n• Center: (0, 0)\n• Vertices: (0, ±a)\n• Co-Vertices: (±b, 0)\n• Foci: (0, ±c), where c² = a² + b²\n• Asymptotes: y = ±(a/b)x', 'image': 'assets/images/vertical_origin.png', 'type': 'formula'},
    {'title': 'Horizontal Hyperbola (Center at (h, k))', 'content': 'Standard form: (x - h)²/a² - (y - k)²/b² = 1\n• Center: (h, k)\n• Vertices: (h ± a, k)\n• Co-Vertices: (h, k ± b)\n• Foci: (h ± c, k), where c² = a² + b²\n• Asymptotes: y = ±(b/a)(x - h) + k', 'image': 'assets/images/horizontal_hk.png', 'type': 'formula'},
    {'title': 'Vertical Hyperbola (Center at (h, k))', 'content': 'Standard form: (y - k)²/a² - (x - h)²/b² = 1\n• Center: (h, k)\n• Vertices: (h, k ± a)\n• Co-Vertices: (h ± b, k)\n• Foci: (h, k ± c), where c² = a² + b²\n• Asymptotes: y = ±(a/b)(x - h) + k', 'image': 'assets/images/vertical_hk.png', 'type': 'formula'},
    {'title': 'Eccentricity of a Hyperbola', 'content': 'Eccentricity (e) = c/a, where c² = a² + b²\n• Always greater than 1\n• e measures how "stretched" the hyperbola is compared to a circle or ellipse.', 'image': 'assets/images/eccentricity.png', 'type': 'formula'},
    {'title': 'General Form to Standard Form', 'content': 'Given: Ax² + By² + Cx + Dy + E = 0\n1. Group x and y terms\n2. Complete the square\n3. Rearrange to match standard form\n4. Divide to make right-hand side = 1', 'image': 'assets/images/general_to_standard.png', 'type': 'formula'},
  ];

  void nextStep() {
    if (currentStep < hyperbolaSteps.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = hyperbolaSteps[currentStep];

    return Scaffold(
      appBar: AppBar(title: const Text('Hyperbola Formulas')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(step['title'], style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Expanded(child: SingleChildScrollView(child: Column(children: [if (step['image'] != null) Image.asset(step['image'], height: 200), const SizedBox(height: 12), Text(step['content'], style: const TextStyle(fontSize: 16))]))),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [ElevatedButton(onPressed: previousStep, child: const Text('Back')), ElevatedButton(onPressed: nextStep, child: const Text('Next'))]),
          ],
        ),
      ),
    );
  }
}
