import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DefinitionHyperBolaSection extends StatefulWidget {
  const DefinitionHyperBolaSection({Key? key}) : super(key: key);

  @override
  State<DefinitionHyperBolaSection> createState() => _DefinitionSectionState();
}

class _DefinitionSectionState extends State<DefinitionHyperBolaSection> {
  int currentStep = 0;
  bool isPlaying = false;
  final player = AudioPlayer();

  Future<void> play() async {
    try {
      await player.setAsset('assets/Audio/HYPERBOLA_definition.wav');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Playing', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green));

      await player.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load ${e}', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }

  Future<void> pause() async {
    await player.pause();
  }

  final List<Map<String, dynamic>> steps = [
    {'title': 'What is a Hyperbola?', 'content': 'A hyperbola is a type of conic section formed when a plane intersects both halves of a double right circular cone at an angle. This results in two open, mirror-image curves.', 'image': 'assets/images/Hyperbola2.jpg'},
    {'title': 'Focus, Directrix, and Eccentricity', 'content': 'Each branch of a hyperbola has a focus, and the distances to the foci define its shape. The eccentricity of a hyperbola is greater than 1, distinguishing it from ellipses and circles.', 'image': 'assets/images/Hyperbola3.jpg'},
    {'title': 'Standard Equation', 'content': 'The standard form of a hyperbola is (x²/a²) - (y²/b²) = 1 or (y²/a²) - (x²/b²) = 1, depending on the orientation. This equation defines the curve’s symmetry and shape.', 'image': 'assets/images/Hyperbola4.jpg'},
  ];

  void nextStep() {
    if (currentStep < steps.length - 1) {
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
    final currentStepData = steps[currentStep];

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        await player.pause();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hyperbola', textAlign: TextAlign.center),
          actions: [
            if (isPlaying == false)
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    isPlaying = true;
                  });
                  play();
                },
                icon: Icon(Icons.play_circle),
                label: Text('Play'),
              ),

            if (isPlaying == true)
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    isPlaying = false;
                  });
                  pause();
                },
                icon: Icon(Icons.pause_circle),
                label: Text('Pause'),
              ),
          ],
        ),
        body: Column(
          children: [
            // Progress indicator
            Container(padding: const EdgeInsets.all(16.0), child: Column(children: [Text('Step ${currentStep + 1} of ${steps.length}', style: const TextStyle(fontSize: 14, color: Colors.grey)), const SizedBox(height: 8), LinearProgressIndicator(value: (currentStep + 1) / steps.length, backgroundColor: Colors.grey[300], valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue))])),

            // Main content area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(currentStepData['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 20),

                      // Image (if available)
                      if (currentStepData['image'] != null) ...[Center(child: Image.asset(currentStepData['image'], height: 200, fit: BoxFit.contain)), const SizedBox(height: 20)],

                      // Content
                      Text(currentStepData['content'], style: const TextStyle(fontSize: 16, height: 1.5)),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),

            // Navigation buttons section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(color: Colors.grey[100], boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, -2))]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  ElevatedButton.icon(onPressed: currentStep > 0 ? previousStep : null, icon: const Icon(Icons.arrow_back), label: const Text('Back'), style: ElevatedButton.styleFrom(backgroundColor: currentStep > 0 ? Colors.grey[300] : Colors.grey[200], foregroundColor: currentStep > 0 ? Colors.black : Colors.grey, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))),

                  // Step indicator dots
                  Row(children: List.generate(steps.length, (index) => Container(margin: const EdgeInsets.symmetric(horizontal: 3), width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: index == currentStep ? Colors.blue : Colors.grey[300])))),

                  // Next Button
                  ElevatedButton.icon(onPressed: currentStep < steps.length - 1 ? nextStep : null, icon: const Icon(Icons.arrow_forward), label: Text(currentStep < steps.length - 1 ? 'Next' : 'Done'), style: ElevatedButton.styleFrom(backgroundColor: currentStep < steps.length - 1 ? Colors.blue : Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
