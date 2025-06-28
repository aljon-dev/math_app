import 'package:flutter/material.dart';

class EllipseIntroScreen extends StatelessWidget {
  const EllipseIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child: Scaffold(
      appBar: AppBar(title: const Text('Real-life Ellipse Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExampleCard(
              context,
              'Running Track Field',
              'A running track field is an oval-shaped path designed for running, '
                  'usually with two straight sides and two curved ends.',
              'assets/running_track.jpg',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Football',
              'A football is ellipse-shaped because of its importance in aerodynamics, '
                  'better grip/handling, and unpredictable bounce which affects gameplay.',
              'assets/football.jpg',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Swimming Pool',
              'Architects use elliptical shapes in designs for both aesthetic and functional reasons. '
                  'Ellipses create visually pleasing and dynamic spaces.',
              'assets/swimming_pool.jpg',
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildExampleCard(BuildContext context, String title, String content, String imagePath) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.indigo[800])), const SizedBox(height: 12), Text(content, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5)), const SizedBox(height: 16), Center(child: Image.asset(imagePath, width: 250, height: 200, fit: BoxFit.cover))])));
  }
}
