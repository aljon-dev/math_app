import 'package:flutter/material.dart';
import 'package:math_app/Curve.dart';
import 'package:video_player/video_player.dart';

class ConicSectionIntroPage extends StatefulWidget {
  const ConicSectionIntroPage({Key? key}) : super(key: key);

  @override
  State<ConicSectionIntroPage> createState() => _ConicSectionIntroPageState();
}

class _ConicSectionIntroPageState extends State<ConicSectionIntroPage> {
  late VideoPlayerController _controller;
  bool _showControls = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/Videos/conic_section.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play(); // Optional: autoplay
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _skipIntro() {
    // Handle skip action here (e.g., navigate to main page)
    Navigator.pop(context);
  }

  void togglePause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(title: const Text('Introduction to Conic Sections', style: TextStyle(fontWeight: FontWeight.w600)), backgroundColor: Colors.white, elevation: 0, foregroundColor: Colors.black87),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Container - Made Smaller
            Container(
              margin: const EdgeInsets.all(16),
              height: 220, // Fixed height to make it smaller
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:
                    _controller.value.isInitialized
                        ? Stack(
                          children: [
                            SizedBox(height: 220, child: Center(child: AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller)))),
                            Positioned.fill(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showControls = !_showControls;
                                  });
                                },
                                child: AnimatedOpacity(
                                  opacity: _showControls ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Container(
                                    color: Colors.black.withOpacity(0.3),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(child: Container()), // Empty space instead of play button
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          child: Column(
                                            children: [
                                              VideoProgressIndicator(_controller, allowScrubbing: true, colors: VideoProgressColors(playedColor: Colors.blue, bufferedColor: Colors.grey.withOpacity(0.5), backgroundColor: Colors.grey.withOpacity(0.3))),

                                              const SizedBox(height: 6),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('${formatDuration(_controller.value.position)} / ${formatDuration(_controller.value.duration)}', style: TextStyle(fontSize: 12)),

                                                  Row(children: [IconButton(onPressed: () => togglePause(), icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 20))]),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                        : Container(height: 220, color: Colors.grey[200], child: const Center(child: CircularProgressIndicator())),
              ),
            ),

            // Content Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Row(children: [Icon(Icons.school, color: Colors.blue[600], size: 28), const SizedBox(width: 12), const Expanded(child: Text('What is Conic Sections?', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87)))]),

                  const SizedBox(height: 20),

                  // Definition
                  Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.blue[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.blue[200]!)), child: const Text('A curve, generated by intersecting a right circular cone with a plane is termed as \'conic\'.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87, height: 1.5))),

                  const SizedBox(height: 20),

                  // Conic sections diagram
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.grey[300]!)),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/conicintro.jpg', // You'll need to add this image
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(height: 200, color: Colors.grey[200], child: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.image, size: 48, color: Colors.grey), SizedBox(height: 8), Text('Conic Sections Explanation Diagram', style: TextStyle(color: Colors.grey))])));
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text('Conic sections explanation', style: TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Explanation
                  const Text('A cone generally has two identical conical shapes known as nappes. We can get various shapes depending upon the angle of the cut between the plane and the cone and its nappe. By cutting a cone by a plane at different angles, we get the following shapes:', style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.6)),

                  const SizedBox(height: 20),

                  // Types header
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Continue Button
            Container(
              margin: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CurvesIntroScreen()));
                  setState(() {
                    _controller.pause();
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue[600], foregroundColor: Colors.white, minimumSize: const Size.fromHeight(56), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 2),
                child: const Text('Continue to Lessons', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildConicTypes() {
    final types = [
      {'name': 'Circle', 'icon': Icons.circle_outlined, 'color': Colors.green},
      {'name': 'Parabola', 'icon': Icons.show_chart, 'color': Colors.orange},
      {'name': 'Ellipse', 'icon': Icons.hvac, 'color': Colors.purple},
      {'name': 'Hyperbola', 'icon': Icons.timeline, 'color': Colors.red},
    ];

    return types.map((type) {
      return Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: (type['color'] as Color).withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: (type['color'] as Color).withOpacity(0.3))), child: Row(children: [Icon(type['icon'] as IconData, color: type['color'] as Color, size: 24), const SizedBox(width: 12), Text(type['name'] as String, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87))]));
    }).toList();
  }
}
