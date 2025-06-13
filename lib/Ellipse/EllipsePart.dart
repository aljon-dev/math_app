import 'package:flutter/material.dart';
import 'dart:math';

class EllipsePartsScreen extends StatefulWidget {
  @override
  _EllipsePartsScreenState createState() => _EllipsePartsScreenState();
}

class _EllipsePartsScreenState extends State<EllipsePartsScreen> {
  String selectedPart = '';

  final Map<String, String> descriptions = {'Center': 'The midpoint where the major and minor axes intersect.', 'Vertices': 'The endpoints of the major axis.', 'Co-vertices': 'The endpoints of the minor axis.', 'Major Axis': 'The longest diameter that passes through the foci.', 'Minor Axis': 'The shortest diameter, perpendicular to the major axis.', 'Semi-major Axis': 'Half of the major axis from the center to a vertex.', 'Semi-minor Axis': 'Half of the minor axis from the center to a co-vertex.', 'Foci': 'Two fixed points inside the ellipse, used to define its shape.', 'Latus Rectum': 'A line segment perpendicular to the major axis through each focus.', 'Eccentricity': 'A measure of how "stretched" the ellipse is.', 'Axis of Symmetry': 'The major and minor axes are both axes of symmetry.'};

  void selectPart(String part) {
    setState(() {
      selectedPart = part;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ellipse Parts")),
      body: Column(
        children: [
          SizedBox(height: 50),
          Text("Ellipse Parts", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.orange)),

          SizedBox(height: 300, child: CustomPaint(painter: EllipsePainter(selectedPart), child: Container())),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children:
                  descriptions.keys.map((part) {
                    final isSelected = selectedPart == part;
                    return GestureDetector(onTap: () => selectPart(part), child: Card(elevation: isSelected ? 4 : 1, color: isSelected ? Colors.amber[100] : Colors.white, margin: const EdgeInsets.symmetric(vertical: 6), child: ListTile(title: Text(part, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)), trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]))));
                  }).toList(),
            ),
          ),
          if (selectedPart.isNotEmpty) Container(width: double.infinity, margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color.fromARGB(255, 7, 78, 129), borderRadius: BorderRadius.circular(8)), child: Text(descriptions[selectedPart] ?? '', style: TextStyle(fontSize: 16, color: Colors.white))),
        ],
      ),
    );
  }
}

class EllipsePainter extends CustomPainter {
  final String selectedPart;

  EllipsePainter(this.selectedPart);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final double rx = 100; // semi-major
    final double ry = 60; // semi-minor

    // Base ellipse
    canvas.drawOval(
      Rect.fromCenter(center: center, width: rx * 2, height: ry * 2),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = Colors.black,
    );

    // Center point
    canvas.drawCircle(
      center,
      5,
      Paint()
        ..color = selectedPart == 'Center' ? Colors.red : Colors.black
        ..style = PaintingStyle.fill,
    );

    final Paint highlight =
        Paint()
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke
          ..color = Colors.purple;

    final double c = sqrt((rx * rx) - (ry * ry)); // distance from center to focus

    // Major Axis
    if (selectedPart == 'Major Axis' || selectedPart == 'Axis of Symmetry') {
      canvas.drawLine(
        Offset(center.dx - rx, center.dy),
        Offset(center.dx + rx, center.dy),
        Paint()
          ..strokeWidth = 2
          ..color = selectedPart == 'Axis of Symmetry' ? Colors.green : Colors.orange,
      );
    }

    // Minor Axis
    if (selectedPart == 'Minor Axis' || selectedPart == 'Axis of Symmetry') {
      canvas.drawLine(
        Offset(center.dx, center.dy - ry),
        Offset(center.dx, center.dy + ry),
        Paint()
          ..strokeWidth = 2
          ..color = selectedPart == 'Axis of Symmetry' ? Colors.green : Colors.blue,
      );
    }

    // Vertices
    if (selectedPart == 'Vertices') {
      canvas.drawCircle(Offset(center.dx - rx, center.dy), 5, highlight);
      canvas.drawCircle(Offset(center.dx + rx, center.dy), 5, highlight);
    }

    // Co-vertices
    if (selectedPart == 'Co-vertices') {
      canvas.drawCircle(Offset(center.dx, center.dy - ry), 5, highlight);
      canvas.drawCircle(Offset(center.dx, center.dy + ry), 5, highlight);
    }

    // Semi-major Axis
    if (selectedPart == 'Semi-major Axis') {
      canvas.drawLine(center, Offset(center.dx + rx, center.dy), highlight);
    }

    // Semi-minor Axis
    if (selectedPart == 'Semi-minor Axis') {
      canvas.drawLine(center, Offset(center.dx, center.dy - ry), highlight);
    }

    // Foci
    if (selectedPart == 'Foci') {
      canvas.drawCircle(Offset(center.dx - c, center.dy), 5, highlight);
      canvas.drawCircle(Offset(center.dx + c, center.dy), 5, highlight);
    }

    // Latus Rectum (simplified as vertical lines through each focus)
    if (selectedPart == 'Latus Rectum') {
      final paint =
          Paint()
            ..strokeWidth = 2
            ..color = Colors.deepPurple;
      canvas.drawLine(Offset(center.dx - c, center.dy - 10), Offset(center.dx - c, center.dy + 10), paint);
      canvas.drawLine(Offset(center.dx + c, center.dy - 10), Offset(center.dx + c, center.dy + 10), paint);
    }

    // Eccentricity (visual representation via text only)
    if (selectedPart == 'Eccentricity') {
      final textPainter = TextPainter(text: TextSpan(text: 'e = c/a', style: TextStyle(color: Colors.black, fontSize: 16)), textDirection: TextDirection.ltr);
      textPainter.layout();
      textPainter.paint(canvas, Offset(center.dx + 10, center.dy - 40));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
