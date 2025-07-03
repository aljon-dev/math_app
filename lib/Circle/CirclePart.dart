import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class CirclePartsScreen extends StatefulWidget {
  @override
  _CirclePartsScreenState createState() => _CirclePartsScreenState();
}

class _CirclePartsScreenState extends State<CirclePartsScreen> {
  String selectedPart = '';
  final AudioPlayer player = AudioPlayer();
  bool isPlaying = false;

  final Map<String, String> descriptions = {
    'Center': 'The fixed point in plane the center of the circle.', 
    'Radius': 'The fixed distance from the center to the boundary of the circle is called the radius of the circle. Generally, the radius of a circle is denoted by " r.".', 
    'Diameter': 'The diameter of a circle is a line that travels through the center and intersects the circumference at opposing ends. In other terms, the diameter of a circle is the line that goes through its center and splits it into two equal sections,and is the longest chord of a circle.',
    'Circumference' : 'The total distance measured once around the circumference of a circle.'
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
      if (selectedPart == 'Center') {
        await player.setAsset('assets/Audio/Circle_center.mp3');
      }

      if (selectedPart == 'Radius') {
        await player.setAsset('assets/Audio/Circle_radius.wav');
      }

      if (selectedPart == 'Diameter') {
        await player.setAsset('assets/Audio/Circle_definition2.wav');
      }

      if (selectedPart == 'Circumference') {
        await player.setAsset('assets/Audio/Circle_circumference.wav');
      }

      await player.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error playing audio: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        await player.stop();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Circle Parts")),
        body: Column(
          children: [
            SizedBox(height: 20),
            Text("Circle Parts", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red)),
            SizedBox(height: 10),
            SizedBox(height: 250, child: CustomPaint(painter: CirclePainter(selectedPart), child: Container())),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children:
                    ['Center', 'Radius', 'Diameter', 'Circumference'].map((part) {
                      final isSelected = selectedPart == part;
                      return GestureDetector(onTap: () => selectPart(part), child: Card(elevation: isSelected ? 4 : 1, color: isSelected ? Colors.green[100] : Colors.white, margin: const EdgeInsets.symmetric(vertical: 6), child: ListTile(title: Text(part, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)), trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]))));
                    }).toList(),
              ),
            ),
            if (selectedPart.isNotEmpty)
              Column(
                children: [
                  Container(width: double.infinity, margin: const EdgeInsets.all(12), padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.teal[100], borderRadius: BorderRadius.circular(8)), child: Text(descriptions[selectedPart] ?? '', style: TextStyle(fontSize: 16, color: Colors.black87))),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.play_arrow, size: 36, color: Colors.blue),
                        onPressed: () async {
                          await playAudio();
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.pause, size: 36, color: Colors.red),
                        onPressed: () async {
                          await player.pause();
                        },
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
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

    final circlePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = selectedPart == 'Circumference' ? Colors.purple : Colors.black;
    canvas.drawCircle(center, radius, circlePaint);

    final centerPaint =
        Paint()
          ..style = PaintingStyle.fill
          ..color = selectedPart == 'Center' ? Colors.red : Colors.black;
    canvas.drawCircle(center, 5, centerPaint);

    if (selectedPart == 'Radius' || selectedPart == 'Diameter') {
      final radiusPaint =
          Paint()
            ..strokeWidth = 3
            ..color = selectedPart == 'Radius' ? Colors.blue : Colors.grey;
      canvas.drawLine(center, Offset(center.dx + radius, center.dy), radiusPaint);
    }

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
