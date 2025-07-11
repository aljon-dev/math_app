import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math' as math;

class ParabolaPartsScreen extends StatefulWidget {
  @override
  _ParabolaPartsScreenState createState() => _ParabolaPartsScreenState();
}

class _ParabolaPartsScreenState extends State<ParabolaPartsScreen> {
  String selectedPart = '';
  double pValue = 25.0; // Distance from vertex to focus/directrix
  bool showFormula = false;
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  final Map<String, String> descriptions = {
    'Vertex': 'The point on the parabola that is halfway from the focus to the directrix. The highest or lowest point where the parabola changes direction.', 
    'Focus': 'A fixed point inside the parabola used to define its shape.', 
    'Directrix': 'A fixed line outside the parabola that helps define its shape. Works with the focus to determine the parabola\'s curve.', 
    'Axis of Symmetry': 'The line passing through the focus and perpendicular to the directrix. This axis divides the parabola into 2 equal parts.', 
    'Focal Chord': 'A line segment connecting two points on the parabola that passes through the focus.', 
    'Latus Rectum': 'A Focal Chord perpendicular to the axis of symmetry, with its endpoints on the parabola.',
    'Distance p': 'p – the distance from the vertex to the focus or from the vertex to the directrix.' 

    };

  Future<void> selectPart(String part) async {
    setState(() {
      selectedPart = part;
    });
    await player.stop();
    setState(() {
      isPlaying = false;
    });
  }

  Future<void> playAudio() async {
    try {
      if (selectedPart.isEmpty) return;

      // Audio file paths based on selected part
      if (selectedPart == 'Vertex') {
        await player.setAsset('assets/Audio/Parabola_Vertex.mp3');
      } else if (selectedPart == 'Focus') {
        await player.setAsset('assets/Audio/Parabola_Focus.mp3');
      } else if (selectedPart == 'Directrix') {
        await player.setAsset('assets/Audio/Parabola_Directrix.mp3');
      } else if (selectedPart == 'Axis of Symmetry') {
        await player.setAsset('assets/Audio/Parabola_AxisOfSymmetry.mp3');
      } else if (selectedPart == 'Focal Chord') {
        await player.setAsset('assets/Audio/Parabola_FocalChord.mp3');
      } else if (selectedPart == 'Latus Rectum') {
        await player.setAsset('assets/Audio/Parabola_LatusRectum.mp3');
      }

      await player.play();
      setState(() {
        isPlaying = true;
      });

      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            isPlaying = false;
          });
        }
      });
    } on PlayerException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> togglePlayPause() async {
    if (isPlaying) {
      await player.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      await playAudio();
    }
  }

  Future<void> stopAudio() async {
    await player.stop();
    setState(() {
      isPlaying = false;
    });
  }

  void toggleFormula() {
    setState(() {
      showFormula = !showFormula;
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        await player.stop();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Parabola Parts"), backgroundColor: Colors.purple[100], actions: [IconButton(icon: Icon(Icons.functions), onPressed: toggleFormula, tooltip: 'Show Formula')]),
        body: Column(
          children: [
            SizedBox(height: 20),
            Text("Parts of a Parabola", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.purple[800])),

            // P value slider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text('p = ${pValue.toInt()}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Expanded(
                    child: Slider(
                      value: pValue,
                      min: 10.0,
                      max: 50.0,
                      divisions: 40,
                      onChanged: (value) {
                        setState(() {
                          pValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Parabola visualization
            Container(height: 280, margin: EdgeInsets.symmetric(horizontal: 10), child: CustomPaint(painter: ParabolaPainter(selectedPart, pValue), child: Container())),

            // Formula section
            // In the formula section of your build method:
            if (showFormula)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue[200]!)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Standard Form: x² = 4py (where p = ${pValue.toStringAsFixed(1)})', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[800])),
                    SizedBox(height: 8),
                    Text(
                      '• Vertex at origin (0, 0)\n'
                      '• Focus at (0, ${pValue.toStringAsFixed(1)})\n'
                      '• Directrix: y = ${(-pValue).toStringAsFixed(1)}\n'
                      '• Latus Rectum length: ${(4 * pValue).toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 14, color: Colors.blue[700]),
                    ),
                  ],
                ),
              ),
            // Parts list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children:
                    ['Vertex', 'Focus', 'Directrix', 'Axis of Symmetry', 'Focal Chord', 'Latus Rectum', 'Distance p'].map((part) {
                      final isSelected = selectedPart == part;
                      return GestureDetector(onTap: () => selectPart(part), child: Card(elevation: isSelected ? 6 : 2, color: isSelected ? Colors.purple[100] : Colors.white, margin: const EdgeInsets.symmetric(vertical: 4), child: ListTile(title: Text(part, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.purple[800] : Colors.black87)), trailing: Icon(Icons.arrow_forward_ios, size: 16, color: isSelected ? Colors.purple[600] : Colors.grey[600]))));
                    }).toList(),
              ),
            ),

            // Description and audio section
            if (selectedPart.isNotEmpty)
  Container(
    height: 300,
    width: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Close button
        Container(
          height: 40,
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.close, size: 20),
            onPressed: () {
              setState(() {
                selectedPart = '';
                if (isPlaying) player.stop();
              });
            },
          ),
        ),
        // Content area - Now wraps content size
        Flexible(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber[200]!),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Text(
                    selectedPart,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber[800],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    descriptions[selectedPart] ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Audio controls - fixed height
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 28,
                  color: Colors.blue,
                ),
                onPressed: togglePlayPause,
              ),
              SizedBox(width: 20),
              IconButton(
                icon: Icon(
                  Icons.stop,
                  size: 28,
                  color: Colors.red,
                ),
                onPressed: () async {
                  await player.stop();
                  setState(() => isPlaying = false);
                },
              ),
            ],
          ),
        ),
      ],
    ),
  ),
          ],
        ),
      ),
    );
  }
}

class ParabolaPainter extends CustomPainter {
  final String selectedPart;
  final double pValue;

  ParabolaPainter(this.selectedPart, this.pValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.8); // Move down for better view
    final scale = 3.0; // Scale factor for the parabola

    // Paint styles
    final parabolaPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = Colors.purple[600]!;

    final axisPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = selectedPart == 'Axis of Symmetry' ? Colors.green : Colors.grey[400]!;

    final focusPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Focus' ? Colors.red : Colors.blue[700]!;

    final vertexPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Vertex' ? Colors.red : Colors.green[700]!;

    final directrixPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = selectedPart == 'Directrix' ? Colors.red : Colors.orange[600]!;

    final latusRectumPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = selectedPart == 'Latus Rectum' ? Colors.red : Colors.cyan[600]!;

    final focalChordPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = selectedPart == 'Focal Chord' ? Colors.red : Colors.pink[400]!;

    // Draw coordinate axes
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), axisPaint);

    // Draw parabola: x² = 4py
    final path = Path();
    bool pathStarted = false;

    for (double x = -size.width / 2; x <= size.width / 2; x += 2) {
      double y = (x * x) / (4 * pValue);

      if (y <= size.height) {
        final screenX = center.dx + x;
        final screenY = center.dy - y; // Flip Y coordinate

        if (!pathStarted) {
          path.moveTo(screenX, screenY);
          pathStarted = true;
        } else {
          path.lineTo(screenX, screenY);
        }
      }
    }
    canvas.drawPath(path, parabolaPaint);

    // Draw vertex at origin
    canvas.drawCircle(center, selectedPart == 'Vertex' ? 8 : 5, vertexPaint);

    // Draw focus at (0, p)
    final focusPoint = Offset(center.dx, center.dy - pValue);
    canvas.drawCircle(focusPoint, selectedPart == 'Focus' ? 8 : 5, focusPaint);

    // Draw directrix at y = -p
    final directrixY = center.dy + pValue;
    if (directrixY < size.height) {
      canvas.drawLine(Offset(0, directrixY), Offset(size.width, directrixY), directrixPaint);
    }

    // Draw latus rectum
    if (selectedPart == 'Latus Rectum') {
      final latusRectumLength = 2 * pValue; // Half length on each side
      canvas.drawLine(Offset(center.dx - latusRectumLength, focusPoint.dy), Offset(center.dx + latusRectumLength, focusPoint.dy), selectedPart == 'Latus Rectum' ? latusRectumPaint : focalChordPaint);
    }

    if (selectedPart == 'Focal Chord') {
      // Draw a focal chord that passes through the focus
      // Using a simple approach: draw a chord at 45-degree angle through focus

      // For parabola x² = 4py, if we want a line through focus (0, p) with slope m
      // Line equation: y = mx + p
      // Substituting into parabola: x² = 4p(mx + p)
      // Simplifying: x² - 4pmx - 4p² = 0

      final double slope = 0.5; // You can adjust this angle
      final double a = 1.0;
      final double b = -4 * pValue * slope;
      final double c = -4 * pValue * pValue;

      final double discriminant = b * b - 4 * a * c;

      if (discriminant >= 0) {
        final double sqrtDiscriminant = math.sqrt(discriminant);
        final double x1 = (-b - sqrtDiscriminant) / (2 * a);
        final double x2 = (-b + sqrtDiscriminant) / (2 * a);

        // Calculate corresponding y values on the parabola
        final double y1 = (x1 * x1) / (4 * pValue);
        final double y2 = (x2 * x2) / (4 * pValue);

        // Convert to screen coordinates
        final point1 = Offset(center.dx + x1, center.dy - y1);
        final point2 = Offset(center.dx + x2, center.dy - y2);

        // Draw the focal chord
        canvas.drawLine(point1, point2, focalChordPaint);

        // Optional: Draw small circles at the endpoints
        canvas.drawCircle(point1, 3, focalChordPaint..style = PaintingStyle.fill);
        canvas.drawCircle(point2, 3, focalChordPaint..style = PaintingStyle.fill);
        focalChordPaint.style = PaintingStyle.stroke; // Reset to stroke
      }
    }

    // Draw distance p indicators
    if (selectedPart == 'Distance p') {
      final distancePaint =
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.red;

      // Distance from vertex to focus
      canvas.drawLine(center, focusPoint, distancePaint);

      // Distance from vertex to directrix
      if (directrixY < size.height) {
        canvas.drawLine(center, Offset(center.dx, directrixY), distancePaint);
      }
    }

    // Draw labels
    final textStyle = TextStyle(color: Colors.black87, fontSize: 12, fontWeight: FontWeight.bold);

    if (selectedPart == 'Vertex' || selectedPart.isEmpty) {
      _drawText(canvas, 'Vertex (0,0)', center.dx + 10, center.dy - 10, textStyle);
    }

    if (selectedPart == 'Focus' || selectedPart.isEmpty) {
      _drawText(canvas, 'Focus (0,p)', focusPoint.dx + 10, focusPoint.dy - 10, textStyle);
    }

    if (selectedPart == 'Directrix' && directrixY < size.height) {
      _drawText(canvas, 'Directrix y=-p', 10, directrixY - 5, textStyle);
    }
  }

  void _drawText(Canvas canvas, String text, double x, double y, TextStyle style) {
    final textPainter = TextPainter(text: TextSpan(text: text, style: style), textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(x, y));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
