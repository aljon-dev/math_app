import 'package:flutter/material.dart';
import 'package:math_app/Circle/Examples/BasicFormulas.dart';
import 'package:math_app/Circle/Examples/CircleEquation.dart';
import 'package:math_app/Circle/Examples/DistanceMidpoint.dart';
import 'package:math_app/Circle/Examples/GraphicCircle.dart';
import 'package:math_app/Circle/Examples/RealWorld.dart';
import 'package:math_app/Circle/Examples/RealifeApplication.dart';
import 'package:math_app/Circle/Examples/Standartform.dart';

class CircleExamplesApp extends StatelessWidget {
  const CircleExamplesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Circle Examples'),
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
                  'Real-life Applications',
                  Icons.public,
                  Colors.blue,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RealLifeApplicationsScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Basic Circle Formulas',
                  Icons.calculate,
                  Colors.green,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BasicFormulasScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Standard Form of Circle',
                  Icons.functions,
                  Colors.orange,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StandardFormScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Circle Equations',
                  Icons.square_foot,
                  Colors.purple,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CircleEquationsScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Distance & Midpoint Formulas',
                  Icons.straighten,
                  Colors.red,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DistanceMidpointScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Graphing Circles',
                  Icons.graphic_eq,
                  Colors.teal,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GraphingCirclesScreen(),
                    ),
                  ),
                ),
                _buildSectionCard(
                  context,
                  'Real-world Problems',
                  Icons.landscape,
                  Colors.brown,
                  isSmallScreen,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RealWorldProblemsScreen(),
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