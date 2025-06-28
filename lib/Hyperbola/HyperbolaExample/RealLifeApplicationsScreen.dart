import 'package:flutter/material.dart';

class HyperbolaIntroScreen extends StatelessWidget {
  const HyperbolaIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Real-life Examples of Hyperbola')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'REAL LIFE APPLICATIONS OF HYPERBOLA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Image.asset('assets/images/realifeHyperbola.png'),
              _buildExampleItem('a. A guitar is a real-world example of hyperbola because of its sides and how its curved going outwards just like a hyperbola.'),
              _buildExampleItem('b. Kobe Port Tower is a hyperboloid tower in the port city of Kobe, Japan.'),
              _buildExampleItem('c. The shape of most cooling tower is hyperboloid. They are built this way because the broad base allows for greater area to encourage evaporation, then narrows to increase air flow velocity.'),
            ],
          ),
        ),
      ),
    );
  }
  }
  Widget _buildExampleItem(String text) {
    return Padding(padding: const EdgeInsets.only(bottom: 16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(text), const SizedBox(height: 8)]));
  }

