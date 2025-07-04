import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ParabolaDefinitionSection extends StatefulWidget {
  const ParabolaDefinitionSection({Key? key}) : super(key: key);

  @override
  State<ParabolaDefinitionSection> createState() => _DefinitionSectionState();
}

class _DefinitionSectionState extends State<ParabolaDefinitionSection> {
  int currentStep = 0;
  bool isPlaying = false;
  final player = AudioPlayer();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final List<Map<String, dynamic>> steps = [
    {'title': 'What is a parabola?', 'content': 'A parabola is a conic section that is formed when a cone is cut by a plane parallel to one lateral side of the cone.', 'image': 'assets/images/ParabolaDef.png'},
    {'title': 'Geometric Shape', 'content': 'A parabola is a U-shaped plane curve where any point is at an equal distance from a fixed point (called the focus) and from a fixed straight line (called the directrix).', 'image': 'assets/images/Parabola2.jpg'},
    {'title': 'Mathematical Definition', 'content': 'A parabola is a set of all points whose distance from a fixed point, called the focus, is equal to the distance from a fixed line,called the directrix.', 'image': 'assets/images/Parabola3.jpg'},
    {'title': 'Vertex of a Parabola', 'content': 'The point halfway between the focus and the directrix is called the vertex of the parabola. It is the point where the curve changes direction.', 'image': 'assets/images/Parabola3.jpg'},
  ];

  Future<void> play() async {
    try {
      await player.setAsset('assets/Audio/PARABOLA_definition.mp3');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Playing', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.green,
        ),
      );
      await player.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load ${e}', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red,
        ),
      );
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

  Widget _buildZoomableImage(BuildContext context, String imagePath) {
    return Center(
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
          title: Text('Parabola', textAlign: TextAlign.center),
          actions: [
            if (!isPlaying)
              TextButton.icon(
                onPressed: () {
                  setState(() => isPlaying = true);
                  play();
                },
                icon: Icon(Icons.play_circle),
                label: Text('Play'),
              ),
            if (isPlaying)
              TextButton.icon(
                onPressed: () {
                  setState(() => isPlaying = false);
                  pause();
                },
                icon: Icon(Icons.pause_circle),
                label: Text('Pause'),
              ),
            IconButton(
              onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
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
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Step ${currentStep + 1} of ${steps.length}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (currentStep + 1) / steps.length,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentStepData['title'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (currentStepData['image'] != null) ...[
                        _buildZoomableImage(context, currentStepData['image']),
                        const SizedBox(height: 20),
                      ],
                      Text(
                        currentStepData['content'],
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
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
}

class _ZoomableImageScreen extends StatefulWidget {
  final String imagePath;

  const _ZoomableImageScreen({required this.imagePath});

  @override
  _ZoomableImageScreenState createState() => _ZoomableImageScreenState();
}

class _ZoomableImageScreenState extends State<_ZoomableImageScreen> {
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
      appBar: AppBar(
        title: Text('Image Preview'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetZoom,
            tooltip: 'Reset Zoom',
          ),
        ],
      ),
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
              child: Hero(
                tag: 'image-${widget.imagePath}',
                child: Image.asset(
                  widget.imagePath,
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
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: _currentScale < _maxScale ? _zoomIn : null,
                  child: Icon(Icons.zoom_in),
                  backgroundColor: _currentScale < _maxScale
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                SizedBox(height: 8),
                FloatingActionButton(
                  mini: true,
                  onPressed: _currentScale > _minScale ? _zoomOut : null,
                  child: Icon(Icons.zoom_out),
                  backgroundColor: _currentScale > _minScale
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(_currentScale * 100).round()}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}