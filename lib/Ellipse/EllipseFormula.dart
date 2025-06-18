import 'package:flutter/material.dart';

class FormulasEllipseSection extends StatefulWidget {
  const FormulasEllipseSection({Key? key}) : super(key: key);

  @override
  State<FormulasEllipseSection> createState() => _FormulasSectionState();
}

class _FormulasSectionState extends State<FormulasEllipseSection> {
  int currentStep = 0;

  final List<Map<String, dynamic>> steps = [
    {'title': 'FORMULAS OF THE ELLIPSE', 'content': 'Let\'s explore the essential formulas used with ellipses. These help us understand properties like shape, axes, vertices, and focus.', 'image': 'assets/images/ellipse_intro.png', 'type': 'intro'},
    {'title': 'General Equation of an Ellipse', 'content': 'This is the general form used to represent an ellipse in conic sections.', 'formula': r'Ax² + By² + Cx + Dy + E = 0', 'image': 'assets/images/general_equation.png', 'type': 'formula'},
    {'title': 'Eccentricity', 'content': 'Eccentricity defines how "stretched" an ellipse is. It ranges from 0 (a circle) to close to 1.', 'formula': r'e = c / a', 'image': 'assets/images/eccentricity.png', 'type': 'formula'},
    {'title': 'Latus Rectum', 'content': 'Latus Rectum is a chord through a focus perpendicular to the major axis.', 'formula': r'LR = (2b²) / a', 'image': 'assets/images/latus_rectum.png', 'type': 'formula'},
    {'title': 'Standard Form (Center at Origin, Horizontal)', 'content': 'The standard form of the equation of an ellipse with center (0,0) and major axis on the x-axis.', 'formula': r'x² / a² + y² / b² = 1', 'image': 'assets/images/standard_horizontal_origin.png', 'type': 'formula', 'details': '• a > b\n• Major Axis Length = 2a\n• Vertices = (±a, 0)\n• Minor Axis Length = 2b\n• Co-Vertices = (0, ±b)\n• Foci = (±c, 0), where c² = a² - b²'},
    {'title': 'Standard Form (Center at Origin, Vertical)', 'content': 'The standard form of the equation of an ellipse with center (0,0) and major axis on the y-axis.', 'formula': r'x² / b² + y² / a² = 1', 'image': 'assets/images/standard_vertical_origin.png', 'type': 'formula', 'details': '• b > a\n• Major Axis Length = 2a\n• Vertices = (0, ±a)\n• Minor Axis Length = 2b\n• Co-Vertices = (±b, 0)\n• Foci = (0, ±c), where c² = a² - b²'},
    {'title': 'Standard Form (Center at (h, k), Horizontal', 'content': 'The standard form of the equation of an ellipse with center (h,k) and major axis parallel to the x-axis.', 'formula': r'(x - h)² / a² + (y - k)² / b² = 1', 'image': 'assets/images/standard_horizontal_hk.png', 'type': 'formula', 'details': '• a > b\n• Major Axis Length = 2a\n• Vertices = (h ± a, k)\n• Minor Axis Length = 2b\n• Co-Vertices = (h, k ± b)\n• Foci = (h ± c, k), where c² = a² - b²'},
    {'title': 'Standard Form (Center at (h, k), Vertical', 'content': 'The standard form of the equation of an ellipse with center (h,k) and major axis parallel to the y-axis.', 'formula': r'(x - h)² / b² + (y - k)² / a² = 1', 'image': 'assets/images/standard_vertical_hk.png', 'type': 'formula', 'details': '• b > a\n• Major Axis Length = 2a\n• Vertices = (h, k ± a)\n• Minor Axis Length = 2b\n• Co-Vertices = (h ± b, k)\n• Foci = (h, k ± c), where c² = a² - b²'},
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
      appBar: AppBar(title: Text('Ellipse Formula')),
      body: Column(
        children: [
          // Progress indicator
          Container(padding: const EdgeInsets.all(16.0), child: Column(children: [Text('Step ${currentStep + 1} of ${steps.length}', style: const TextStyle(fontSize: 14, color: Colors.grey)), const SizedBox(height: 8), LinearProgressIndicator(value: (currentStep + 1) / steps.length, backgroundColor: Colors.grey[300], valueColor: const AlwaysStoppedAnimation<Color>(Colors.green))])),

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

                    // Details (if available)
                    if (currentStepData['details'] != null) ...[const SizedBox(height: 30), Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[300]!, width: 1)), child: Text(currentStepData['details'], style: const TextStyle(fontSize: 16, height: 1.5)))],
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
                Row(children: List.generate(steps.length, (index) => Container(margin: const EdgeInsets.symmetric(horizontal: 2), width: 6, height: 6, decoration: BoxDecoration(shape: BoxShape.circle, color: index == currentStep ? Colors.green : Colors.grey[300])))),

                // Next Button
                ElevatedButton.icon(onPressed: currentStep < steps.length - 1 ? nextStep : null, icon: const Icon(Icons.arrow_forward), label: Text(currentStep < steps.length - 1 ? 'Next' : 'Done'), style: ElevatedButton.styleFrom(backgroundColor: currentStep < steps.length - 1 ? Colors.green : Colors.blue, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12))),
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
