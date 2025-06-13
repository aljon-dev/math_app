import 'package:flutter/material.dart';

class ParabolaDefinitionSection extends StatefulWidget {
  const ParabolaDefinitionSection({Key? key}) : super(key: key);

  @override
  State<ParabolaDefinitionSection> createState() => _DefinitionSectionState();
}

class _DefinitionSectionState extends State<ParabolaDefinitionSection> {
  int currentStep = 0;

  final List<Map<String, dynamic>> steps = [
    {'title': 'DEFINITION OF THE PARABOLA', 'content': 'Welcome to learning about parabolas! Let\'s explore what makes a parabola special.', 'image': 'assets/images/Parabola1.jpg'},
    {'title': 'What is a parabola?', 'content': 'A parabola is a conic section that is formed when a cone is cut by a plane parallel to one lateral side of the cone.', 'image': 'assets/images/Parabola1.jpg'},
    {'title': 'Geometric Shape', 'content': 'A parabola is a U-shaped plane curve where any point is at an equal distance from a fixed point (called the focus) and from a fixed straight line (called the directrix).', 'image': 'assets/images/Parabola2.jpg'},
    {'title': 'Mathematical Definition', 'content': 'A parabola is the set of all points whose distance from a fixed point, called the focus, is equal to the distance from a fixed line, called the directrix.', 'image': 'assets/images/Parabola3.jpg'},
    {'title': 'Vertex of a Parabola', 'content': 'The point halfway between the focus and the directrix is called the vertex of the parabola. It is the point where the curve changes direction.', 'image': 'assets/images/Parabola3.jpg'},
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

    return Scaffold(
      appBar: AppBar(title: Text('Circle', textAlign: TextAlign.center)),
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
    );
  }
}
