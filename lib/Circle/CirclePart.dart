import 'dart:ui';

import 'package:flutter/material.dart';

class CirclePartsScreen extends StatefulWidget {
  @override
  _CirclePartsScreenState createState() => _CirclePartsScreenState();
}

class _CirclePartsScreenState extends State<CirclePartsScreen> {
  String selectedPart = '';

  final Map<String, String> descriptions = {'Center': 'The fixed point in the center of the circle.', 'Radius': 'The distance from the center to any point on the circle.', 'Diameter': 'A straight line passing from side to side through the center.'};

  void selectPart(String part) {
    setState(() {
      selectedPart = part;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Circle Parts")),
      body: Column(
        children: [
          SizedBox(height: 50),
          Text("Circle Parts", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red)),

          SizedBox(height: 250, child: CustomPaint(painter: CirclePainter(selectedPart), child: Container())),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children:
                  ['Center', 'Radius', 'Diameter'].map((part) {
                    final isSelected = selectedPart == part;
                    return GestureDetector(onTap: () => selectPart(part), child: Card(elevation: isSelected ? 4 : 1, color: isSelected ? Colors.green[100] : Colors.white, margin: const EdgeInsets.symmetric(vertical: 6), child: ListTile(title: Text(part, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)), trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]))));
                  }).toList(),
            ),
          ),
          if (selectedPart.isNotEmpty) Container(width: double.infinity, margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal[100], borderRadius: BorderRadius.circular(8)), child: Text(descriptions[selectedPart] ?? '', style: TextStyle(fontSize: 16, color: Colors.black87))),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final String selectedPart;

  CirclePainter(this.selectedPart);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 100.0;

    // Draw the full circle
    final circlePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.black;
    canvas.drawCircle(center, radius, circlePaint);

    // Center point
    final centerPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Center' ? Colors.red : Colors.black;
    canvas.drawCircle(center, 5, centerPaint);

    // Radius line
    if (selectedPart == 'Radius' || selectedPart == 'Diameter') {
      final radiusPaint =
          Paint()
            ..strokeWidth = 3
            ..color = selectedPart == 'Radius' ? Colors.blue : Colors.grey;

      final endpoint = Offset(center.dx + radius, center.dy);
      canvas.drawLine(center, endpoint, radiusPaint);
    }

    // Diameter line
    if (selectedPart == 'Diameter') {
      final diameterPaint =
          Paint()
            ..strokeWidth = 3
            ..color = Colors.orange;
      canvas.drawLine(Offset(center.dx - radius, center.dy), Offset(center.dx + radius, center.dy), diameterPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
