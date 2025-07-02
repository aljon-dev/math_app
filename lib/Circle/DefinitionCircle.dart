import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class DefinitionSection extends StatefulWidget {
  const DefinitionSection({Key? key}) : super(key: key);

  @override
  State<DefinitionSection> createState() => _DefinitionSectionState();
}

class _DefinitionSectionState extends State<DefinitionSection> {
  int currentStep = 0;
  bool isPlaying = false;
  final player = AudioPlayer();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> play() async {
    try {
      await player.setAsset('assets/Audio/Circle_definition.wav');
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
  
    {'title': 'What is a circle?', 'content': 'A circle is all points equidistant (the distance is called the radius) from one point (which is called the center of the circle). A circle can be formed by slicing a right circular cone with a plane traveling parallel to the base of the cone', 'image': 'assets/images/Circle1.png'},
    {'title': 'Center and Radius', 'content': 'The given point is called the center, (h, k), and the fixed distance is called the radius, r, of the circle.', 'image': 'assets/images/Circle2.png'},
    {'title': 'Geometric Definition', 'content': 'A circle is a basic geometric shape defined as the set of all points in a plane that are equidistant from a fixed point, known as the center. Circles are fundamental in calculus and geometry, playing a crucial role in various mathematical applications, such as area, perimeter (circumference), and motion.', 'image': 'assets/images/Circle2.png'},
    {'title': 'Conic Section', 'content': 'The set of all the points in a plane that are equidistant from a fixed point (center) in the plane is called the circle. A circle is an ellipse in which both the foci coincide with its center. As the foci are at the same point, for a circle, the distance from the center to a focus is zero. This eccentricity gives the circle its round shape. Thus, the eccentricity of any circle is 0. A circle is the conic section with the least deviation from circularity; hence its eccentricity is 0. In a circle, the focus and directrix concepts are somewhat different from other conic sections, but the eccentricity value of 0 still represents its perfect circular shape.', 'image': 'assets/images/Circle3.png'},
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

  void navigateToStep(int index) {
    setState(() {
      currentStep = index;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final currentStepData = steps[currentStep];

    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        await player.pause();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('Circle'),
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
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openEndDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ...steps.asMap().entries.map((entry) {
                final index = entry.key;
                final step = entry.value;

                return ListTile(title: Text(step['title']), selected: currentStep == index, selectedTileColor: Colors.blue.withOpacity(0.1), onTap: () => navigateToStep(index));
              }).toList(),
            ],
          ),
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
