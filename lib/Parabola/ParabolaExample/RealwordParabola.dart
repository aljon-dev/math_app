import 'package:flutter/material.dart';

class ParabolaRealWorldScreen extends StatelessWidget {
  const ParabolaRealWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Real-world Parabola Problems')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProblem(
                context: context,
                problem: '1. Given vertex at (1, 1), opens downward, and has a latus rectum length of 2 units. Find the equation.',
                solution: [
                  'Standard form for downward parabola: (x - h)² = -4p(y - k)',
                  'Vertex (h, k) = (1, 1)',
                  '4p = 2 → p = 0.5',
                  'Equation: (x - 1)² = -2(y - 1)'
                ],
              ),
              const SizedBox(height: 24),
              _buildProblem(
                context: context,
                problem: '2. A bridge has a parabolic arch modeled by (x - 3)² = -8(y - 12). What is the maximum height?',
                solution: [
                  'Equation is in standard form: (x - h)² = -4p(y - k)',
                  'Vertex (h, k) = (3, 12)',
                  'For downward parabola, vertex is the highest point',
                  'Maximum height = 12 meters'
                ],
                image: 'assets/parabola_bridge_problem.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProblem({
    required BuildContext context,
    required String problem,
    required List<String> solution,
    String? image,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              problem,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (image != null) ...[
              const SizedBox(height: 8),
              _buildZoomableImage(context, image),
            ],
            const SizedBox(height: 8),
            const Text(
              'Solution:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...solution
                .map(
                  (step) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text('• $step'),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomableImage(BuildContext context, String imagePath) {
    return SizedBox(
      height: 150,
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
            width: 300,
            height: 150,
            fit: BoxFit.cover,
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
              child: Image.asset(
                height: double.infinity,
                width: double.infinity,
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