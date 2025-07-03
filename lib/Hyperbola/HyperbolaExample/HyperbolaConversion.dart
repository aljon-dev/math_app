import 'package:flutter/material.dart';

class HyperbolaConversionsScreen extends StatelessWidget {
  const HyperbolaConversionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Hyperbola Equation Conversions')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildConversionExample(
                title: '1. Transform General form to standard equation',
                problem: 'Write the standard form of Hyperbola: 9x² - 2y² + 54x + 4y - 11 = 0',
                steps: [
                  '1st: Group all the x\'s and all y\'s but start with positive x² or y²',
                  '(9x² + 54x) - (2y² - 4y) = 11',
                  '2nd: Factor out the coefficient of x² and y² then simplify',
                  '9(x² + 6x) - 2(y² - 2y) = 11',
                  '3rd: Completing the square',
                  'For x: (6/2)² = 9 | For y: (2/2)² = 1',
                  '9(x² + 6x + 9) - 2(y² - 2y + 1) = 11 + 81 - 2',
                  '4th: Factoring and simplify',
                  '9(x + 3)² - 2(y - 1)² = 90',
                  '5th: Equation must be equal to 1',
                  '(x + 3)²/10 - (y - 1)²/45 = 1'
                ],
                        context: context,
                answer: 'Final Answer: (x + 3)²/10 - (y - 1)²/45 = 1',
                graphImage: 'assets/images/hyperbola_graph1.jpg',
              ),
              const SizedBox(height: 24),
              _buildConversionExample(
                title: '2. Transform Standard form to General Form',
                problem: 'Transform: (y - 8)²/25 - (x - 4)²/16 = 1',
                steps: [
                  '1st: Multiply by LCD (25)(16)',
                  '16(y - 8)² - 25(x - 4)² = 400',
                  '2nd: Expand the squared terms',
                  '16(y² - 16y + 64) - 25(x² - 8x + 16) = 400',
                  '3rd: Distribute',
                  '16y² - 256y + 1024 - 25x² + 200x - 400 = 400',
                  '4th: Arrange to General Form',
                  '-25x² + 16y² + 200x - 256y + 224 = 0'
                ],
                context: context,
                answer: 'Final Answer: -25x² + 16y² + 200x - 256y + 224 = 0',
                graphImage: 'assets/images/hyperbola_graph2.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConversionExample({
    required String title,
    required String problem,
    required List<String> steps,
    required String answer,
    required BuildContext context,
    String? graphImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(problem, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...steps.map((step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(step),
            )).toList(),
        const SizedBox(height: 8),
        Text(answer, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
        if (graphImage != null) ...[
          const SizedBox(height: 8),
          _buildZoomableImage(graphImage,context),
        ],
      ],
    );
  }

  Widget _buildZoomableImage(String imagePath,BuildContext context) {
    return SizedBox(
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
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Image not found: $imagePath',
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

// Reuse the same _ZoomableImageScreen implementation from previous example
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
          )
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
                        fontWeight: FontWeight.bold),
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