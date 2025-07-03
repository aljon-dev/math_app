import 'package:flutter/material.dart';

class HyperbolaIntroScreen extends StatelessWidget {
  const HyperbolaIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Real-life Examples of Hyperbola')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'REAL LIFE APPLICATIONS OF HYPERBOLA',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildZoomableImage('assets/images/realifeHyperbola.png',context),
              _buildExampleItem('a. A guitar is a real-world example of hyperbola because of its sides and how its curved going outwards just like a hyperbola.'),
              _buildExampleItem('b. Kobe Port Tower is a hyperboloid tower in the port city of Kobe, Japan.'),
              _buildExampleItem('c. The shape of most cooling tower is hyperboloid. They are built this way because the broad base allows for greater area to encourage evaporation, then narrows to increase air flow velocity.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0), 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Text(text), 
          const SizedBox(height: 8)
        ]
      )
    );
  }

  Widget _buildZoomableImage(String imagePath,BuildContext context) {
    return SizedBox(
      height: 250, // Increased height for better visibility
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
            height: 250,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
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

// Reuse the same _ZoomableImageScreen implementation
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