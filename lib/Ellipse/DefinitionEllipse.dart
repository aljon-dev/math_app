import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DefinitionSectionEllipse extends StatefulWidget {
  const DefinitionSectionEllipse({Key? key}) : super(key: key);

  @override
  State<DefinitionSectionEllipse> createState() => _DefinitionSectionState();
}

class _DefinitionSectionState extends State<DefinitionSectionEllipse> {
  int currentStep = 0;

  bool isPlaying = false;
  final player = AudioPlayer();

  final List<Map<String, dynamic>> steps = [
    {'title': 'What is a Ellipse?', 'content': 'An ellipse is a two-dimensional shape defined by its axes. It forms when a cone is intersected by a plane at an angle with respect to its base.\n\nIt is a set of all points in a plane where the total distance to two fixed points (foci) is constant.\n\nLet’s say, if f₁ and f₂ are two fixed points and k is a positive constant, then the ellipse is the set of points P(x, y) such that:\n\nPf₁ + Pf₂ = k', 'image': 'assets/images/Circle1.jpg'},
  ];

  Future<void> play() async {
    try {
      await player.setAsset('assets/Audio/Ellipse_definition.mp3');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Playing', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green));

      await player.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load ${e}', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }

  Future<void> pause() async {
    await player.pause();
  }

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ellipse'),
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
          // Step indicator
          Container(padding: const EdgeInsets.all(16.0), child: Column(children: [Text('Step ${currentStep + 1} of ${steps.length}', style: const TextStyle(fontSize: 14, color: Colors.grey)), const SizedBox(height: 8), LinearProgressIndicator(value: (currentStep + 1) / steps.length, backgroundColor: Colors.grey[300], valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue))])),

          // Content
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

                    // Image
                    if (currentStepData['image'] != null) ...[Center(child: Image.asset(currentStepData['image'], height: 200, fit: BoxFit.contain)), const SizedBox(height: 20)],

                    // Content
                    if (currentStepData['title'] == 'Parts of an Ellipse') ...[
                      RichText(text: TextSpan(style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black), children: [TextSpan(text: 'An ellipse has several important parts:\n\n'), TextSpan(text: '• Focus: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'An ellipse has two foci (singular: focus), which are fixed points located on the major axis.\n\n'), TextSpan(text: '• Center: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'The midpoint between the two foci. The major and minor axes intersect here at 90°. Denoted by (h, k).\n\n'), TextSpan(text: '• Major axis: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'The longest diameter, stretching from one vertex to the opposite. Each half is the semi-major axis (a).\n\n'), TextSpan(text: '• Minor axis: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'The shortest diameter from one co-vertex to the other. Each half is the semi-minor axis (b).\n\n'), TextSpan(text: '• Vertex: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'Points where the ellipse intersects the major axis.\n\n'), TextSpan(text: '• Co-vertex: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'Points where the ellipse intersects the minor axis.\n\n'), TextSpan(text: '• Latus Rectum: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'Line segments perpendicular to the major axis, passing through each focus.\n\n'), TextSpan(text: '• Eccentricity: ', style: TextStyle(fontWeight: FontWeight.bold)), TextSpan(text: 'The ratio of the distance from a focus to the center, divided by the semi-major axis. It shows how stretched the ellipse is.')])),
                    ] else ...[
                      Text(currentStepData['content'], style: const TextStyle(fontSize: 16, height: 1.5)),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(color: Colors.grey[100], boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 3, offset: const Offset(0, -2))]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back
                ElevatedButton.icon(onPressed: currentStep > 0 ? previousStep : null, icon: const Icon(Icons.arrow_back), label: const Text('Back'), style: ElevatedButton.styleFrom(backgroundColor: currentStep > 0 ? Colors.grey[300] : Colors.grey[200], foregroundColor: currentStep > 0 ? Colors.black : Colors.grey, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))),

                // Dots
                Row(children: List.generate(steps.length, (index) => Container(margin: const EdgeInsets.symmetric(horizontal: 3), width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: index == currentStep ? Colors.blue : Colors.grey[300])))),

                // Next
                ElevatedButton.icon(onPressed: currentStep < steps.length - 1 ? nextStep : null, icon: const Icon(Icons.arrow_forward), label: Text(currentStep < steps.length - 1 ? 'Next' : 'Done'), style: ElevatedButton.styleFrom(backgroundColor: currentStep < steps.length - 1 ? Colors.blue : Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
