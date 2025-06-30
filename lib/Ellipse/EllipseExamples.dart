import 'package:flutter/material.dart';
import 'package:math_app/Ellipse/EllipseExamples/EllipseConversion.dart';
import 'package:math_app/Ellipse/EllipseExamples/EllipseGraph.dart';
import 'package:math_app/Ellipse/EllipseExamples/EllipseIntro.dart';
import 'package:math_app/Ellipse/EllipseExamples/EllipseProperties.dart';
import 'package:math_app/Ellipse/EllipseExamples/RealWordEllipse.dart';

class EllipseExamplesApp extends StatelessWidget {
  const EllipseExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ellipse Examples'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Adjust layout based on screen width
            final bool isSmallScreen = constraints.maxWidth < 400;
            
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: [
                _buildSectionCard(
                  context,
                  'Real-life Examples',
                  Icons.public,
                  Colors.indigo,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EllipseIntroScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Equation Conversions',
                  Icons.swap_horiz,
                  Colors.teal,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EllipseConversionsScreen(),
                    ),
                  ),
                ), 
                _buildSectionCard(
                  context,
                  'From Properties',
                  Icons.tune,
                  Colors.orange,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EllipseFromPropertiesScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'From Graphs',
                  Icons.graphic_eq,
                  Colors.purple,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EllipseFromGraphScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Real-world Problems',
                  Icons.architecture,
                  Colors.green,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EllipseRealWorldScreen(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    bool isSmallScreen,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}