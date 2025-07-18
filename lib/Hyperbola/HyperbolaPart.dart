import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math' as math;

class HyperbolaPartsScreen extends StatefulWidget {
  @override
  _HyperbolaPartsScreenState createState() => _HyperbolaPartsScreenState();
}

class _HyperbolaPartsScreenState extends State<HyperbolaPartsScreen> {
  String selectedPart = '';
  double aValue = 40.0; // Semi-major axis
  double bValue = 30.0; // Semi-minor axis
  bool isHorizontal = true; // true for horizontal, false for vertical
  bool showFormula = false;
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  final Map<String, String> descriptions = {'Center': 'The midpoint of the line joining the two foci is called the center of the hyperbola. The major and the minor axes intersect at this point at  90° . The center of the above hyperbola is at (0,0).', 'Foci': 'The hyperbola has two foci and their coordinates are F (c, 0) and F` (-c,0).', 'Vertices': 'The points where the hyperbola intersects the axis are called the vertices. The vertices of the hyperbola are (a,0) and (-a,0).', 'Co-vertices': ' Has 2 co-vertices (singular: co-vertex). Like the vertices on the transverse axis, the co-vertices are the points on the conjugate axis that are equidistant from the center. The co-vertices of the given hyperbola are (b,0) and (-b,0).', 'Major Axis': 'It is the distance between the end vertices. The length of the major axis of the hyperbola is 2a units.', 'Minor Axis': 'It is the distance between the end co-vertices. The length of the minor axis of the hyperbola is 2b units.', 'Transverse Axis': 'The line passing through the two foci and the center of the hyperbola. A hyperbola can be classified as either horizontal or vertical based on the orientation of its transverse axis.', 'Conjugate Axis': 'The line passing through the center of the hyperbola and perpendicular to the transverse axis is called the conjugate axis of the hyperbola.', 'Asymptotes': ' Has 2 asymptotes, which are lines that pass through the center of the hyperbola. The branches of the hyperbola get closer and closer to these asymptotes as they extend outward, but they never actually touch them.', 'Latus Rectum': 'The latus rectum is a line drawn perpendicular to the transverse axis of the hyperbola and is passing through the foci of the hyperbola. The length of the latus rectum of the hyperbola is 2b²/a and the lengths of the semi-latus rectum is b²/a.'};

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
    if (selectedPart == 'Center') {
      await player.setAsset('assets/Audio/Hyperbola_(center).wav');
    } else if (selectedPart == 'Foci') {
      await player.setAsset('assets/Audio/Hyperbola_(foci).wav');
    } else if (selectedPart == 'Vertices') {
      await player.setAsset('assets/Audio/Hyperbola_(vertices).mp3');
    } else if (selectedPart == 'Co-vertices') {
      await player.setAsset('assets/Audio/Hyperbola_(co-vertex).wav');
    } else if (selectedPart == 'Major Axis') {
      await player.setAsset('assets/Audio/Hyperbola_(major axis).wav');
    } else if (selectedPart == 'Minor Axis') {
      await player.setAsset('assets/Audio/Hyperbola_(minor axis).wav');
    } else if (selectedPart == 'Transverse Axis') {
      await player.setAsset('assets/Audio/Hyperbola_(transverse axis).mp3');
    } else if (selectedPart == 'Conjugate Axis') {
      await player.setAsset('assets/Audio/Hyperbola_(conjugate axis).wav');
    } else if (selectedPart == 'Asymptotes') {
      await player.setAsset('assets/Audio/Hyperbola_(asymptote).mp3');
    } else if (selectedPart == 'Latus Rectum') {
      await player.setAsset('assets/Audio/Hyperbola_(latus rectum).wav');
    }

      await player.play();
      setState(() {
        isPlaying = true;
      });

      // Listen for when audio completes
      player.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.completed) {
          setState(() {
            isPlaying = false;
          });
        }
      });
    } on PlayerException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Audio Player Error: ${e.message}')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unexpected Error: $e')));
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

  void toggleOrientation() {
    setState(() {
      isHorizontal = !isHorizontal;
    });
  }

  void toggleFormula() {
    setState(() {
      showFormula = !showFormula;
    });
  }

  double get cValue => math.sqrt(aValue * aValue + bValue * bValue);

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
        appBar: AppBar(title: Text("Hyperbola Parts"), backgroundColor: Colors.indigo[100], actions: [IconButton(icon: Icon(Icons.functions), onPressed: toggleFormula, tooltip: 'Show Formula'), IconButton(icon: Icon(Icons.rotate_90_degrees_ccw), onPressed: toggleOrientation, tooltip: 'Toggle Orientation')]),
        body: Column(
          children: [
            SizedBox(height: 15),
            Text("${isHorizontal ? 'Horizontal' : 'Vertical'} Hyperbola", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo[800])),

            // Show formula when toggled
            if (showFormula) Container(padding: EdgeInsets.all(16), margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.blue[200]!)), child: Column(children: [Text("Standard Equation:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[800])), SizedBox(height: 8), Text(isHorizontal ? "(x²/${aValue.toStringAsFixed(1)}²) - (y²/${bValue.toStringAsFixed(1)}²) = 1" : "(y²/${aValue.toStringAsFixed(1)}²) - (x²/${bValue.toStringAsFixed(1)}²) = 1", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.indigo)), SizedBox(height: 8), Text("Asymptotes:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.blue[800])), SizedBox(height: 8), Text(isHorizontal ? "y = ±(${bValue.toStringAsFixed(1)}/${aValue.toStringAsFixed(1)})x" : "y = ±(${aValue.toStringAsFixed(1)}/${bValue.toStringAsFixed(1)})x", style: TextStyle(fontSize: 16, color: Colors.indigo))])),

            // Parameter controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('a = ${aValue.toInt()}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Slider(
                          value: aValue,
                          min: 20.0,
                          max: 60.0,
                          divisions: 40,
                          onChanged: (value) {
                            setState(() {
                              aValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('b = ${bValue.toInt()}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Slider(
                          value: bValue,
                          min: 15.0,
                          max: 50.0,
                          divisions: 35,
                          onChanged: (value) {
                            setState(() {
                              bValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Text('c = ${cValue.toStringAsFixed(1)}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),

            // Hyperbola visualization
            Container(height: 260, margin: EdgeInsets.symmetric(horizontal: 10), child: CustomPaint(painter: HyperbolaPainter(selectedPart, aValue, bValue, isHorizontal), child: Container())),

            // Parts list
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children:
                    ['Center', 'Foci', 'Vertices', 'Co-vertices', 'Major Axis', 'Minor Axis', 'Transverse Axis', 'Conjugate Axis', 'Asymptotes', 'Latus Rectum'].map((part) {
                      final isSelected = selectedPart == part;
                      return GestureDetector(onTap: () => selectPart(part), child: Card(elevation: isSelected ? 6 : 2, color: isSelected ? Colors.indigo[100] : Colors.white, margin: const EdgeInsets.symmetric(vertical: 3), child: ListTile(title: Text(part, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.indigo[800] : Colors.black87)), trailing: Icon(Icons.arrow_forward_ios, size: 14, color: isSelected ? Colors.indigo[600] : Colors.grey[600]))));
                    }).toList(),
              ),
            ),
            // Replace your entire "if (selectedPart.isNotEmpty)" section with this:

            // Replace your entire "if (selectedPart.isNotEmpty)" section with this:
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
                    Flexible(child: Container(width: double.infinity, margin: EdgeInsets.symmetric(horizontal: 12), padding: EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.amber[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.amber[200]!)), child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [Text(selectedPart, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber[800])), SizedBox(height: 8), Text(descriptions[selectedPart] ?? '', style: TextStyle(fontSize: 14, color: Colors.black87))]))),
                    // Audio controls - fixed height
                    Container(
                      height: 60,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 28, color: Colors.blue), onPressed: togglePlayPause),
                          SizedBox(width: 20),
                          IconButton(
                            icon: Icon(Icons.stop, size: 28, color: Colors.red),
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

class HyperbolaPainter extends CustomPainter {
  final String selectedPart;
  final double aValue;
  final double bValue;
  final bool isHorizontal;

  HyperbolaPainter(this.selectedPart, this.aValue, this.bValue, this.isHorizontal);

  double get cValue => math.sqrt(aValue * aValue + bValue * bValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final scale = 2.5;

    // Paint styles
    final hyperbolaPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = Colors.indigo[700]!;

    final axisPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = Colors.grey[400]!;

    final selectedPaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4
          ..color = Colors.red;

    final focusPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Foci' ? Colors.red : Colors.blue[700]!;

    final centerPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Center' ? Colors.red : Colors.green[700]!;

    final vertexPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Vertices' ? Colors.red : Colors.purple[600]!;

    final coVertexPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Co-vertices' ? Colors.red : Colors.orange[600]!;

    // Draw coordinate axes
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), axisPaint);
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), axisPaint);

    // Draw hyperbola branches
    _drawHyperbola(canvas, center, scale, hyperbolaPaint, size);

    // Draw center
    canvas.drawCircle(center, selectedPart == 'Center' ? 8 : 4, centerPaint);

    // Draw foci
    if (isHorizontal) {
      final focus1 = Offset(center.dx - cValue * scale, center.dy);
      final focus2 = Offset(center.dx + cValue * scale, center.dy);
      canvas.drawCircle(focus1, selectedPart == 'Foci' ? 8 : 5, focusPaint);
      canvas.drawCircle(focus2, selectedPart == 'Foci' ? 8 : 5, focusPaint);
    } else {
      final focus1 = Offset(center.dx, center.dy - cValue * scale);
      final focus2 = Offset(center.dx, center.dy + cValue * scale);
      canvas.drawCircle(focus1, selectedPart == 'Foci' ? 8 : 5, focusPaint);
      canvas.drawCircle(focus2, selectedPart == 'Foci' ? 8 : 5, focusPaint);
    }

    // Draw vertices
    if (isHorizontal) {
      final vertex1 = Offset(center.dx - aValue * scale, center.dy);
      final vertex2 = Offset(center.dx + aValue * scale, center.dy);
      canvas.drawCircle(vertex1, selectedPart == 'Vertices' ? 8 : 5, vertexPaint);
      canvas.drawCircle(vertex2, selectedPart == 'Vertices' ? 8 : 5, vertexPaint);
    } else {
      final vertex1 = Offset(center.dx, center.dy - aValue * scale);
      final vertex2 = Offset(center.dx, center.dy + aValue * scale);
      canvas.drawCircle(vertex1, selectedPart == 'Vertices' ? 8 : 5, vertexPaint);
      canvas.drawCircle(vertex2, selectedPart == 'Vertices' ? 8 : 5, vertexPaint);
    }

    // Draw co-vertices
    if (isHorizontal) {
      final coVertex1 = Offset(center.dx, center.dy - bValue * scale);
      final coVertex2 = Offset(center.dx, center.dy + bValue * scale);
      canvas.drawCircle(coVertex1, selectedPart == 'Co-vertices' ? 8 : 4, coVertexPaint);
      canvas.drawCircle(coVertex2, selectedPart == 'Co-vertices' ? 8 : 4, coVertexPaint);
    } else {
      final coVertex1 = Offset(center.dx - bValue * scale, center.dy);
      final coVertex2 = Offset(center.dx + bValue * scale, center.dy);
      canvas.drawCircle(coVertex1, selectedPart == 'Co-vertices' ? 8 : 4, coVertexPaint);
      canvas.drawCircle(coVertex2, selectedPart == 'Co-vertices' ? 8 : 4, coVertexPaint);
    }

    // Draw axes
    if (selectedPart == 'Major Axis' || selectedPart == 'Transverse Axis') {
      if (isHorizontal) {
        canvas.drawLine(Offset(center.dx - aValue * scale - 20, center.dy), Offset(center.dx + aValue * scale + 20, center.dy), selectedPaint);
      } else {
        canvas.drawLine(Offset(center.dx, center.dy - aValue * scale - 20), Offset(center.dx, center.dy + aValue * scale + 20), selectedPaint);
      }
    }

    if (selectedPart == 'Minor Axis' || selectedPart == 'Conjugate Axis') {
      if (isHorizontal) {
        canvas.drawLine(Offset(center.dx, center.dy - bValue * scale - 20), Offset(center.dx, center.dy + bValue * scale + 20), selectedPaint);
      } else {
        canvas.drawLine(Offset(center.dx - bValue * scale - 20, center.dy), Offset(center.dx + bValue * scale + 20, center.dy), selectedPaint);
      }
    }

    // Draw asymptotes
    if (selectedPart == 'Asymptotes') {
      final asymptotePaint =
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.red
            ..strokeCap = StrokeCap.round;

      double slope = isHorizontal ? bValue / aValue : aValue / bValue;

      canvas.drawLine(Offset(0, center.dy - slope * (center.dx)), Offset(size.width, center.dy + slope * (size.width - center.dx)), asymptotePaint);
      canvas.drawLine(Offset(0, center.dy + slope * (center.dx)), Offset(size.width, center.dy - slope * (size.width - center.dx)), asymptotePaint);
    }

    // Draw latus rectum
    if (selectedPart == 'Latus Rectum') {
      final latusLength = (bValue * bValue / aValue) * scale;
      final latusPaint =
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..color = Colors.red;

      if (isHorizontal) {
        final focus1X = center.dx - cValue * scale;
        final focus2X = center.dx + cValue * scale;

        canvas.drawLine(Offset(focus1X, center.dy - latusLength), Offset(focus1X, center.dy + latusLength), latusPaint);
        canvas.drawLine(Offset(focus2X, center.dy - latusLength), Offset(focus2X, center.dy + latusLength), latusPaint);
      } else {
        final focus1Y = center.dy - cValue * scale;
        final focus2Y = center.dy + cValue * scale;

        canvas.drawLine(Offset(center.dx - latusLength, focus1Y), Offset(center.dx + latusLength, focus1Y), latusPaint);
        canvas.drawLine(Offset(center.dx - latusLength, focus2Y), Offset(center.dx + latusLength, focus2Y), latusPaint);
      }
    }

    // Draw labels for key points
    _drawLabels(canvas, center, scale);
  }

  void _drawHyperbola(Canvas canvas, Offset center, double scale, Paint paint, Size size) {
    final path1 = Path();
    final path2 = Path();
    bool path1Started = false, path2Started = false;

    if (isHorizontal) {
      // Horizontal hyperbola: x²/a² - y²/b² = 1
      for (double x = aValue; x <= aValue + 50; x += 1) {
        double y = bValue * math.sqrt((x * x) / (aValue * aValue) - 1);

        final screenX1 = center.dx + x * scale;
        final screenX2 = center.dx - x * scale;
        final screenY1 = center.dy - y * scale;
        final screenY2 = center.dy + y * scale;

        if (screenX1 >= 0 && screenX1 <= size.width) {
          if (!path1Started) {
            path1.moveTo(screenX1, screenY1);
            path1.moveTo(screenX1, screenY2);
            path1Started = true;
          } else {
            path1.lineTo(screenX1, screenY1);
            path1.moveTo(screenX1, screenY2);
            path1.lineTo(screenX1, screenY2);
          }
        }

        if (screenX2 >= 0 && screenX2 <= size.width) {
          if (!path2Started) {
            path2.moveTo(screenX2, screenY1);
            path2.moveTo(screenX2, screenY2);
            path2Started = true;
          } else {
            path2.lineTo(screenX2, screenY1);
            path2.moveTo(screenX2, screenY2);
            path2.lineTo(screenX2, screenY2);
          }
        }
      }
    } else {
      // Vertical hyperbola: y²/a² - x²/b² = 1
      for (double y = aValue; y <= aValue + 50; y += 1) {
        double x = bValue * math.sqrt((y * y) / (aValue * aValue) - 1);

        final screenX1 = center.dx - x * scale;
        final screenX2 = center.dx + x * scale;
        final screenY1 = center.dy - y * scale;
        final screenY2 = center.dy + y * scale;

        if (screenY1 >= 0 && screenY1 <= size.height) {
          if (!path1Started) {
            path1.moveTo(screenX1, screenY1);
            path1.moveTo(screenX2, screenY1);
            path1Started = true;
          } else {
            path1.lineTo(screenX1, screenY1);
            path1.moveTo(screenX2, screenY1);
            path1.lineTo(screenX2, screenY1);
          }
        }

        if (screenY2 >= 0 && screenY2 <= size.height) {
          if (!path2Started) {
            path2.moveTo(screenX1, screenY2);
            path2.moveTo(screenX2, screenY2);
            path2Started = true;
          } else {
            path2.lineTo(screenX1, screenY2);
            path2.moveTo(screenX2, screenY2);
            path2.lineTo(screenX2, screenY2);
          }
        }
      }
    }

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  void _drawLabels(Canvas canvas, Offset center, double scale) {
    final textStyle = TextStyle(color: Colors.black87, fontSize: 10, fontWeight: FontWeight.bold);

    if (selectedPart == 'Center' || selectedPart.isEmpty) {
      _drawText(canvas, 'O', center.dx + 8, center.dy - 8, textStyle);
    }

    if (selectedPart == 'Foci') {
      if (isHorizontal) {
        _drawText(canvas, 'F₁', center.dx - cValue * scale - 15, center.dy - 15, textStyle);
        _drawText(canvas, 'F₂', center.dx + cValue * scale + 5, center.dy - 15, textStyle);
      } else {
        _drawText(canvas, 'F₁', center.dx + 8, center.dy - cValue * scale - 15, textStyle);
        _drawText(canvas, 'F₂', center.dx + 8, center.dy + cValue * scale + 5, textStyle);
      }
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
