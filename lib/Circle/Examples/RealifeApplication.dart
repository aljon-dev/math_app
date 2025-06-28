import 'package:flutter/material.dart';

class RealLifeApplicationsScreen extends StatelessWidget {
  const RealLifeApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Real-life Applications')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExampleCard(
                context,
                'Analog Clocks',
                'Analog clocks utilize the circular path of their hands to represent the passage of time. '
                    'The face of the clock is a circle, and the hands move along circular paths with a common center. '
                    'The length of each hand represents a radius, and the circumference of the circular path is divided '
                    'into units representing hours, minutes, and seconds.',
                'assets/clock_example.jpg',
              ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Earthquake Location',
                'Seismologists use circles to determine and locate the center of earthquakes. '
                    'By measuring seismic waves from multiple locations, they can draw circles around '
                    'each observation point with radii equal to the estimated distance to the epicenter. '
                    'The intersection of these circles identifies the earthquake\'s location.',
                'assets/earthquake_example.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, String title, String content, String imagePath) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.blue[800])),
            const SizedBox(height: 12),
            Text(content, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5)),
            if (imagePath.isNotEmpty) ...[const SizedBox(height: 16), Center(child: Image.asset(imagePath, width: 200, height: 200, fit: BoxFit.contain))],
          ],
        ),
      ),
    );
  }
}
