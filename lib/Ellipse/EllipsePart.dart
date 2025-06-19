import 'package:flutter/material.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';

class EllipsePartsScreen extends StatefulWidget {
  @override
  _EllipsePartsScreenState createState() => _EllipsePartsScreenState();
}

class _EllipsePartsScreenState extends State<EllipsePartsScreen> {
  String selectedPart = '';
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  final Map<String, String> descriptions = {'Focus': 'Has two foci. The foci (singular: focus) are the fixed points of the ellipse, which are located on the major axis.', 'Center': 'The midpoint between the two foci. The major and minor axes intersect at this point at 90°. It is denoted by (h, k).', 'Major Axis': 'It is the distance between the end vertices. The center divides the major axis into two equal halves. Each half is called the semi-major axis or major radius, represented by \'a\'.', 'Minor Axis': 'It is the distance between the end co-vertices. Center divides the minor axis into two halves. Each half is called the semi-minor axis or minor radius, represented by \'b\'.', 'Vertex': 'It is the point where the ellipse intersects the major axis. In other words, the two extreme points that form the major axis are the vertices.', 'Co-vertex': 'It is the point where the ellipse intersects the minor axis. In other words, the two extreme points that form the minor axis are the co-vertices.', 'Latus Rectum': 'The line segments perpendicular to the major axis through any of the foci such that their endpoints lie on the ellipse.', 'Eccentricity': 'The ratio of the distance of the focus from the center of the ellipse, and the distance of one end of the major axis from the center of the ellipse.'};

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
      if (selectedPart == 'Focus') {
        await player.setAsset('assets/Audio/Ellipse(focus).mp3');
      } else if (selectedPart == 'Center') {
        await player.setAsset('assets/Audio/Ellipse(center).mp3');
      } else if (selectedPart == 'Major Axis') {
        await player.setAsset('assets/Audio/Ellipse(major axis).mp3');
      } else if (selectedPart == 'Minor Axis') {
        await player.setAsset('assets/Audio/Ellipse(minor axis).mp3');
      } else if (selectedPart == 'Vertex') {
        await player.setAsset('assets/Audio/Ellipse(vertex).mp3');
      } else if (selectedPart == 'Co-vertex') {
        await player.setAsset('assets/Audio/Ellipse(co-vertex).mp3');
      } else if (selectedPart == 'Latus Rectum') {
        await player.setAsset('assets/Audio/Ellipse(latus rectum).mp3');
      } else if (selectedPart == 'Eccentricity') {
        await player.setAsset('assets/Audio/Ellipse(eccentricity).mp3');
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
        appBar: AppBar(title: Text("Ellipse Parts")),
        body: Column(
          children: [
            SizedBox(height: 20),
            Text("Ellipse Parts", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.orange)),
            SizedBox(height: 10),
            SizedBox(height: 250, child: CustomPaint(painter: EllipsePainter(selectedPart), child: Container())),
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
            if (selectedPart.isNotEmpty)
              Column(
                children: [
                  Container(width: double.infinity, margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Color.fromARGB(255, 7, 78, 129), borderRadius: BorderRadius.circular(8)), child: Text(descriptions[selectedPart] ?? '', style: TextStyle(fontSize: 16, color: Colors.white))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow, size: 36, color: Colors.blue),
                        onPressed: () async {
                          if (isPlaying) {
                            await player.pause();
                            setState(() {
                              isPlaying = false;
                            });
                          } else {
                            await playAudio();
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.stop, size: 36, color: Colors.red),
                        onPressed: () async {
                          await player.stop();
                          setState(() {
                            isPlaying = false;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
          ],
        ),
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
    if (selectedPart == 'Major Axis') {
      canvas.drawLine(
        Offset(center.dx - rx, center.dy),
        Offset(center.dx + rx, center.dy),
        Paint()
          ..strokeWidth = 2
          ..color = Colors.orange,
      );
    }

    // Minor Axis
    if (selectedPart == 'Minor Axis') {
      canvas.drawLine(
        Offset(center.dx, center.dy - ry),
        Offset(center.dx, center.dy + ry),
        Paint()
          ..strokeWidth = 2
          ..color = Colors.blue,
      );
    }

    // Vertices
    if (selectedPart == 'Vertex') {
      canvas.drawCircle(Offset(center.dx - rx, center.dy), 5, highlight);
      canvas.drawCircle(Offset(center.dx + rx, center.dy), 5, highlight);
    }

    // Co-vertices
    if (selectedPart == 'Co-vertex') {
      canvas.drawCircle(Offset(center.dx, center.dy - ry), 5, highlight);
      canvas.drawCircle(Offset(center.dx, center.dy + ry), 5, highlight);
    }

    // Foci
    if (selectedPart == 'Focus') {
      canvas.drawCircle(Offset(center.dx - c, center.dy), 5, highlight);
      canvas.drawCircle(Offset(center.dx + c, center.dy), 5, highlight);
    }

    // Latus Rectum
    if (selectedPart == 'Latus Rectum') {
      final paint =
          Paint()
            ..strokeWidth = 4
            ..color = Colors.deepPurple;
      canvas.drawLine(Offset(center.dx - c, center.dy - 45), Offset(center.dx - c, center.dy + 47), paint);
      canvas.drawLine(Offset(center.dx + c, center.dy - 45), Offset(center.dx + c, center.dy + 47), paint);
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
