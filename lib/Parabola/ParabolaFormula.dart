import 'package:flutter/material.dart';

class FormulasParabolaSection extends StatefulWidget {
  const FormulasParabolaSection({Key? key}) : super(key: key);

  @override
  State<FormulasParabolaSection> createState() => _FormulasSectionState();
}

class _FormulasSectionState extends State<FormulasParabolaSection> {
  int currentStep = 0;

  final List<Map<String, dynamic>> parabolaSteps = [
    {'title': 'Upward Opening Parabola (Vertex at Origin)', 'content': 'Standard form: x² = 4py\n• Vertex: (0,0)\n• Focus: (0, p)\n• Directrix: y = -p\n• Axis: x = 0\n• Latus Rectum: length = |4p|, endpoints at (±2p, p)', 'image': 'assets/images/upward_origin.png', 'type': 'formula'},
    {'title': 'Downward Opening Parabola (Vertex at Origin)', 'content': 'Standard form: x² = -4py\n• Vertex: (0,0)\n• Focus: (0, -p)\n• Directrix: y = p\n• Axis: x = 0\n• Latus Rectum: length = |4p|, endpoints at (±2p, -p)', 'image': 'assets/images/downward_origin.png', 'type': 'formula'},
    {'title': 'Right Opening Parabola (Vertex at Origin)', 'content': 'Standard form: y² = 4px\n• Vertex: (0,0)\n• Focus: (p, 0)\n• Directrix: x = -p\n• Axis: y = 0\n• Latus Rectum: length = |4p|, endpoints at (p, ±2p)', 'image': 'assets/images/right_origin.png', 'type': 'formula'},
    {'title': 'Left Opening Parabola (Vertex at Origin)', 'content': 'Standard form: y² = -4px\n• Vertex: (0,0)\n• Focus: (-p, 0)\n• Directrix: x = p\n• Axis: y = 0\n• Latus Rectum: length = |4p|, endpoints at (-p, ±2p)', 'image': 'assets/images/left_origin.png', 'type': 'formula'},
    {'title': 'Upward Opening (Vertex at (h, k))', 'content': 'Standard form: (x - h)² = 4p(y - k)\n• Vertex: (h, k)\n• Focus: (h, k + p)\n• Directrix: y = k - p\n• Axis: x = h\n• Latus Rectum: endpoints at (h ± 2p, k + p)', 'image': 'assets/images/upward_hk.png', 'type': 'formula'},
    {'title': 'Downward Opening (Vertex at (h, k))', 'content': 'Standard form: (x - h)² = -4p(y - k)\n• Vertex: (h, k)\n• Focus: (h, k - p)\n• Directrix: y = k + p\n• Axis: x = h\n• Latus Rectum: endpoints at (h ± 2p, k - p)', 'image': 'assets/images/downward_hk.png', 'type': 'formula'},
    {'title': 'Right Opening (Vertex at (h, k))', 'content': 'Standard form: (y - k)² = 4p(x - h)\n• Vertex: (h, k)\n• Focus: (h + p, k)\n• Directrix: x = h - p\n• Axis: y = k\n• Latus Rectum: endpoints at (h + p, k ± 2p)', 'image': 'assets/images/right_hk.png', 'type': 'formula'},
    {'title': 'Left Opening (Vertex at (h, k))', 'content': 'Standard form: (y - k)² = -4p(x - h)\n• Vertex: (h, k)\n• Focus: (h - p, k)\n• Directrix: x = h + p\n• Axis: y = k\n• Latus Rectum: endpoints at (h - p, k ± 2p)', 'image': 'assets/images/left_hk.png', 'type': 'formula'},
  ];

  void nextStep() {
    if (currentStep < parabolaSteps.length - 1) {
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
    final currentStepData = parabolaSteps[currentStep];

    return Scaffold(
      body: Column(
        children: [
          // Progress indicator
          Container(padding: const EdgeInsets.all(16.0), child: Column(children: [Text('Step ${currentStep + 1} of ${parabolaSteps.length}', style: const TextStyle(fontSize: 14, color: Colors.grey)), const SizedBox(height: 8), LinearProgressIndicator(value: (currentStep + 1) / parabolaSteps.length, backgroundColor: Colors.grey[300], valueColor: const AlwaysStoppedAnimation<Color>(Colors.green))])),

          // Main content area
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    const SizedBox(height: 20),
                    Text(currentStepData['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),

                    // Image (if available)
                    if (currentStepData['image'] != null) Center(child: Image.asset(currentStepData['image'], fit: BoxFit.contain, height: 200)),
                    const SizedBox(height: 20),

                    // Content
                    Text(currentStepData['content'], style: const TextStyle(fontSize: 16, height: 1.5)),
                    const SizedBox(height: 20),

                    // Formula (if available)
                    if (currentStepData['formula'] != null) ...[const SizedBox(height: 30), Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: _getFormulaBackgroundColor(currentStepData['type']), borderRadius: BorderRadius.circular(12), border: Border.all(color: _getFormulaBorderColor(currentStepData['type']), width: 2)), child: Center(child: Text(currentStepData['formula'], style: TextStyle(fontFamily: 'Math', fontSize: 24, fontWeight: FontWeight.bold, color: _getFormulaTextColor(currentStepData['type'])))))],
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
                Row(children: List.generate(parabolaSteps.length, (index) => Container(margin: const EdgeInsets.symmetric(horizontal: 2), width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: index == currentStep ? Colors.green : Colors.grey[300])))),

                // Next Button
                ElevatedButton.icon(onPressed: currentStep < parabolaSteps.length - 1 ? nextStep : null, icon: const Icon(Icons.arrow_forward), label: Text(currentStep < parabolaSteps.length - 1 ? 'Next' : 'Done'), style: ElevatedButton.styleFrom(backgroundColor: currentStep < parabolaSteps.length - 1 ? Colors.green : Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getFormulaBackgroundColor(String? type) {
    switch (type) {
      case 'formula':
        return Colors.blue[50]!;
      case 'derivation':
        return Colors.green[50]!;
      default:
        return Colors.grey[50]!;
    }
  }

  Color _getFormulaBorderColor(String? type) {
    switch (type) {
      case 'formula':
        return Colors.blue[300]!;
      case 'derivation':
        return Colors.green[300]!;
      default:
        return Colors.grey[300]!;
    }
  }

  Color _getFormulaTextColor(String? type) {
    switch (type) {
      case 'formula':
        return Colors.blue[800]!;
      case 'derivation':
        return Colors.green[800]!;
      default:
        return Colors.black;
    }
  }
}
