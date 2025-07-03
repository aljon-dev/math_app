import 'package:flutter/material.dart';

class HyperbolaFromGraphScreen extends StatelessWidget {
  const HyperbolaFromGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Hyperbola Graphs')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGraphExample(
                equation: 'x²/16 - y²/36 = 1',
                properties: [
                  'Center: (0, 0)',
                  'Orientation: Horizontal',
                  'a = 4, b = 6',
                  'Vertices: (±4, 0)',
                  'Foci: (±√52, 0) ≈ (±7.21, 0)',
                  'Asymptotes: y = ±(6/4)x = ±(3/2)x',
                  'Transverse axis length: 2a = 8',
                  'Conjugate axis length: 2b = 12'
                ],
                context: context,
                graphImage: 'assets/images/hyperbola_graph3.png',
              ),
              const SizedBox(height: 24),
              _buildGraphExample(
                equation: '4y² - 49x² = 196 → y²/49 - x²/4 = 1',
                properties: [
                  'Center: (0, 0)',
                  'Orientation: Vertical',
                  'a = 7, b = 2',
                  'Vertices: (0, ±7)',
                  'Foci: (0, ±√53) ≈ (0, ±7.28)',
                  'Asymptotes: y = ±(7/2)x',
                  'Transverse axis length: 2a = 14',
                  'Conjugate axis length: 2b = 4'
                ],
                 context: context,
                graphImage: 'assets/images/hyperbola_graph4.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGraphExample({
    required String equation,
    required List<String> properties,
    required BuildContext context,
    String? graphImage,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Equation: $equation',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...properties
            .map((prop) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(prop),
                ))
            .toList(),
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