import 'package:flutter/material.dart';

class ParabolaFromGraphScreen extends StatelessWidget {
  const ParabolaFromGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Parabola Graphs')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGraphExample(
                context: context,
                problem: '1. Find the standard equation of this graph:',
                solution: [
                  'Vertex at (3, 0)',
                  'Focus at (6, 0)',
                  'Endpoints at (6, ±6)',
                  'Opens to the right → (y - k)² = 4p(x - h)',
                  '4p = 12 (length of latus rectum)',
                  'Equation: y² = 12(x - 3)'
                ],
                graphImage: 'assets/parabola_graph5.jpg',
              ),
              const SizedBox(height: 24),
              _buildGraphExample(
                context: context,
                problem: '2. Find the standard equation of this graph:',
                solution: [
                  'Vertex at (2, 2)',
                  'Focus at (2, 0)',
                  'Endpoints at (0, -2) and (0, 6)',
                  'Opens downward → (x - h)² = -4p(y - k)',
                  '4p = 8 (length of latus rectum)',
                  'Equation: (x - 2)² = -8(y - 2)'
                ],
                graphImage: 'assets/parabola_graph4.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGraphExample({
    required BuildContext context,
    required String problem,
    required List<String> solution,
    String? graphImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          problem,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        if (graphImage != null) ...[
          const SizedBox(height: 8),
          _buildZoomableImage(context, graphImage),
        ],
        const SizedBox(height: 8),
        const Text('Solution:', style: TextStyle(fontWeight: FontWeight.bold)),
        ...solution
            .map(
              (step) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text('• $step'),
              ),
            )
            .toList(),
      ],
    );
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