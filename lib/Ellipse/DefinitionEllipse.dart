import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class DefinitionSectionEllipse extends StatefulWidget {
  const DefinitionSectionEllipse({Key? key}) : super(key: key);

  @override
  State<DefinitionSectionEllipse> createState() => _DefinitionSectionState();
}

class _DefinitionSectionState extends State<DefinitionSectionEllipse> {
  int currentStep = 0;

  bool isPlaying = false;
  final player = AudioPlayer();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Map<String, dynamic>> steps = [
    {'title': 'What is a Ellipse?', 'content': 'An ellipse is a two-dimensional shape defined by its axes. It forms when a cone is intersected by a plane at an angle with respect to its base.\n\nIt is a set of all points in a plane where the total distance to two fixed points (foci) is constant.\n\nLet’s say, if f₁ and f₂ are two fixed points and k is a positive constant, then the ellipse is the set of points P(x, y) such that:\n\nPf₁ + Pf₂ = k', 'image': 'assets/images/ellipseintro.png'},
  ];

  Future<void> play() async {
    try {
      await player.setAsset('assets/Audio/Ellipse_definition.mp3');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Playing', style: TextStyle(color: Colors.white)), backgroundColor: Colors.green));

      await player.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load ${e}', style: TextStyle(color: Colors.white)), backgroundColor: Colors.red));
    }
  }

  Future<void> pause() async {
    await player.pause();
  }

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

  void navigateToStep(int index) {
    setState(() {
      currentStep = index;
    });
    Navigator.of(context).pop();
  }

 @override
Widget build(BuildContext context) {
  final currentStepData = steps[currentStep];

  return PopScope(
    onPopInvokedWithResult: (didPop, result) async {
      await player.pause();
    },
    child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Ellipse'),
        actions: [
          if (isPlaying == false)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isPlaying = true;
                });
                play();
              },
              icon: Icon(Icons.play_circle),
              label: Text('Play'),
            ),
          if (isPlaying == true)
            TextButton.icon(
              onPressed: () {
                setState(() {
                  isPlaying = false;
                });
                pause();
              },
              icon: Icon(Icons.pause_circle),
              label: Text('Pause'),
            ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            ...steps.asMap().entries.map((entry) {
              final index = entry.key;
              final step = entry.value;
              return ListTile(
                title: Text(step['title']),
                selected: currentStep == index,
                selectedTileColor: Colors.blue.withOpacity(0.1),
                onTap: () => navigateToStep(index),
              );
            }).toList(),
          ],
        ),
      ),
      body: Column(
        children: [
          // Step indicator
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text('Step ${currentStep + 1} of ${steps.length}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey)),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: (currentStep + 1) / steps.length,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(currentStepData['title'],
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),

                    // Image - Changed to use _buildZoomableImage
                    if (currentStepData['image'] != null) ...[
                      _buildZoomableImage(context, currentStepData['image']),
                      const SizedBox(height: 20),
                    ],

                    // Content
                    if (currentStepData['title'] == 'Parts of an Ellipse') ...[
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontSize: 16, height: 1.5, color: Colors.black),
                          children: [
                            TextSpan(text: 'An ellipse has several important parts:\n\n'),
                            // ... rest of your text spans
                          ],
                        ),
                      ),
                    ] else ...[
                      Text(currentStepData['content'],
                          style: const TextStyle(fontSize: 16, height: 1.5)),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),

          // Navigation buttons
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back
                ElevatedButton.icon(
                  onPressed: currentStep > 0 ? previousStep : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentStep > 0
                        ? Colors.grey[300]
                        : Colors.grey[200],
                    foregroundColor:
                        currentStep > 0 ? Colors.black : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),

                // Dots
                Row(
                  children: List.generate(
                    steps.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == currentStep
                            ? Colors.blue
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),

                // Next
                ElevatedButton.icon(
                  onPressed: currentStep < steps.length - 1 ? nextStep : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(currentStep < steps.length - 1 ? 'Next' : 'Done'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: currentStep < steps.length - 1
                        ? Colors.blue
                        : Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
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

 Widget _buildZoomableImage(BuildContext context, String imagePath) {
  return Center(  // Wrap with Center widget
    child: SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _ZoomableImageScreen(imagePath: imagePath),
            ),
          );
        },
        child: Hero(
          tag: 'image-$imagePath',
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 200,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text(
                'Image not found',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
}

   Widget _buildZoomableImage(BuildContext context, String imagePath) {
    return SizedBox(
      height: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _ZoomableImageScreen(imagePath: imagePath),
            ),
          );
        },
        child: Hero(
          tag: 'image-$imagePath',
          child: Image.asset(
            imagePath,
            width: 250,
            height: 250,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Center(
              child: Text(
                'Image not found',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
      ),
    );
  }



class _ZoomableImageScreen extends StatefulWidget {
  final String imagePath;

  const _ZoomableImageScreen({required this.imagePath});

  @override
  _ZoomableImageScreenState createState() => _ZoomableImageScreenState();
}

class _ZoomableImageScreenState extends State<_ZoomableImageScreen > {
  final TransformationController _controller = TransformationController();
  double _currentScale = 1.0;
  final double _minScale = 0.5;
  final double _maxScale = 4.0;
  final double _scaleStep = 0.5;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _zoomIn() {
    setState(() {
      _currentScale = (_currentScale + _scaleStep).clamp(_minScale, _maxScale);
      _controller.value = Matrix4.identity()..scale(_currentScale);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentScale = (_currentScale - _scaleStep).clamp(_minScale, _maxScale);
      _controller.value = Matrix4.identity()..scale(_currentScale);
    });
  }

  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
      _controller.value = Matrix4.identity();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Preview'), actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _resetZoom, tooltip: 'Reset Zoom')]),
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              transformationController: _controller,
              panEnabled: true,
              minScale: _minScale,
              maxScale: _maxScale,
              onInteractionUpdate: (details) {
                setState(() {
                  _currentScale = _controller.value.getMaxScaleOnAxis();
                });
              },
              child: Image.asset(height: double.infinity, width: double.infinity, widget.imagePath, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))),
            ),
          ),
          Positioned(right: 16, bottom: 100, child: Column(children: [FloatingActionButton(mini: true, onPressed: _currentScale < _maxScale ? _zoomIn : null, child: Icon(Icons.zoom_in), backgroundColor: _currentScale < _maxScale ? Theme.of(context).primaryColor : Colors.grey), SizedBox(height: 8), FloatingActionButton(mini: true, onPressed: _currentScale > _minScale ? _zoomOut : null, child: Icon(Icons.zoom_out), backgroundColor: _currentScale > _minScale ? Theme.of(context).primaryColor : Colors.grey), SizedBox(height: 8), Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)), child: Text('${(_currentScale * 100).round()}%', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)))])),
        ],
      ),
    );
  }
}


