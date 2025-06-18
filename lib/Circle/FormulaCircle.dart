import 'package:flutter/material.dart';

class FormulasSection extends StatefulWidget {
  const FormulasSection({Key? key}) : super(key: key);

  @override
  State<FormulasSection> createState() => _FormulasSectionState();
}

class _FormulasSectionState extends State<FormulasSection> {
  int currentStep = 0;

  final List<Map<String, dynamic>> steps = [
    {'title': 'FORMULA OF THE CIRCLE', 'content': 'Let\'s explore the essential formulas used with circles. These formulas help us calculate important properties like area, circumference, and equations.', 'type': 'intro'},
    {'title': 'Area Formula', 'content': 'The area of a circle is the space enclosed within its circumference.', 'formula': r'A = π r²', 'type': 'formula'},
    {'title': 'Diameter Formula', 'content': 'The diameter is the longest distance across a circle, passing through the center.', 'formula': r'd = 2r', 'type': 'formula'},
    {'title': 'Circumference Formula', 'content': 'The circumference is the distance around the edge of the circle.', 'formula': r'c = 2π r', 'type': 'formula'},
    {'title': 'Standard Form (Center at h,k)', 'content': 'This is the standard equation of a circle with center at point (h,k) and radius r.', 'formula': r'(x - h)² + (y - k)² = r²', 'type': 'formula'},
    {'title': 'Standard Form (Center at Origin)', 'content': 'When the center of the circle is at the origin (0,0), the equation simplifies.', 'formula': r'x² + y² = r²', 'type': 'formula'},
    {'title': 'General Form', 'content': 'The general form represents a circle equation in expanded form.', 'formula': r'x² + y² + Ax + By + C = 0', 'type': 'formula'},
    {'title': 'DERIVING THE STANDARD FORM', 'content': 'Now let\'s understand how we derive the standard form of a circle equation using the distance formula.', 'type': 'derivation_intro'},
    {'title': 'Distance Formula', 'content': 'We start with the distance formula between two points.', 'formula': r'd = √[(x₂ - x₁)² + (y₂ - y₁)²]', 'type': 'derivation'},
    {'title': 'Substitute Values', 'content': 'We substitute the center (h,k), point (x,y), and distance r into the formula.', 'formula': r'r = √[(x - h)² + (y - k)²]', 'type': 'derivation'},
    {'title': 'Square Both Sides', 'content': 'To eliminate the square root, we square both sides of the equation.', 'formula': r'r² = (x - h)² + (y - k)²', 'type': 'derivation'},
    {'title': 'Standard Form Result', 'content': 'Rearranging gives us the standard form of a circle equation.', 'formula': r'(x - h)² + (y - k)² = r²', 'type': 'derivation'},
    {'title': 'Circle at Origin - Setup', 'content': 'For a circle centered at the origin (0,0), we follow the same process.', 'formula': r'r = √[(x - 0)² + (y - 0)²]', 'type': 'derivation'},
    {'title': 'Simplify', 'content': 'Simplifying the equation when the center is at (0,0).', 'formula': r'r = √[x² + y²]', 'type': 'derivation'},
    {'title': 'Final Form at Origin', 'content': 'Squaring both sides gives us the equation for a circle centered at the origin.', 'formula': r'x² + y² = r²', 'type': 'derivation'},
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
      appBar: AppBar(title: Text('Circle Formula')),
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
                    const SizedBox(height: 100),
                    Text(currentStepData['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
