import 'package:flutter/material.dart';

class HyperbolaFromPropertiesScreen extends StatelessWidget {
  const HyperbolaFromPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Hyperbola Properties')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPropertiesExample(equation: '(x + 3)²/10 - (y - 1)²/45 = 1', properties: [_buildProperty('Center', '(h, k) = (-3, 1)'), _buildProperty('Orientation', 'Horizontal'), _buildProperty('a²', '10 → a = √10 ≈ 3.16'), _buildProperty('b²', '45 → b = √45 ≈ 6.71'), _buildProperty('c²', 'a² + b² = 55 → c = √55 ≈ 7.42'), _buildProperty('Vertices', '(-3 ± √10, 1) ≈ (0.16, 1), (-6.16, 1)'), _buildProperty('Foci', '(-3 ± √55, 1) ≈ (4.42, 1), (-10.42, 1)')], context: context, graphImage: 'assets/images/hyperbola_graph1.jpg'),
              const SizedBox(height: 24),
              _buildPropertiesExample(equation: '(y - 8)²/25 - (x - 4)²/16 = 1', properties: [_buildProperty('Center', '(h, k) = (4, 8)'), _buildProperty('Orientation', 'Vertical'), _buildProperty('a²', '25 → a = 5'), _buildProperty('b²', '16 → b = 4'), _buildProperty('c²', 'a² + b² = 41 → c = √41 ≈ 6.40'), _buildProperty('Vertices', '(4, 8 ± 5) = (4, 13), (4, 3)'), _buildProperty('Foci', '(4, 8 ± √41) ≈ (4, 14.40), (4, 1.60)'), _buildProperty('Asymptotes', 'y - 8 = ±(5/4)(x - 4)')], context: context, graphImage: 'assets/images/hyperbola_graph2.jpg'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertiesExample({required String equation, required List<Widget> properties, required BuildContext context, String? graphImage}) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Equation: $equation', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...properties,
            if (graphImage != null) ...[const SizedBox(height: 8), _buildZoomableImage(graphImage, context)],
          ],
        ),
      ),
    );
  }

  Widget _buildProperty(String name, String value) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [SizedBox(width: 80, child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold))), const Text(': '), Expanded(child: Text(value))]));
  }

  Widget _buildZoomableImage(String imagePath, BuildContext context) {
    return SizedBox(
      height: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => _ZoomableImageScreen(imagePath: imagePath)));
        },
        child: Hero(tag: 'image-$imagePath', child: Image.asset(imagePath, width: double.infinity, height: 200, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Container(height: 200, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8)), child: Center(child: Text('Image not found: $imagePath', style: TextStyle(color: Colors.grey)))))),
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
              child: Hero(tag: 'image-${widget.imagePath}', child: Image.asset(widget.imagePath, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey))))),
            ),
          ),
          Positioned(right: 16, bottom: 100, child: Column(children: [FloatingActionButton(mini: true, onPressed: _currentScale < _maxScale ? _zoomIn : null, child: Icon(Icons.zoom_in), backgroundColor: _currentScale < _maxScale ? Theme.of(context).primaryColor : Colors.grey), SizedBox(height: 8), FloatingActionButton(mini: true, onPressed: _currentScale > _minScale ? _zoomOut : null, child: Icon(Icons.zoom_out), backgroundColor: _currentScale > _minScale ? Theme.of(context).primaryColor : Colors.grey), SizedBox(height: 8), Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)), child: Text('${(_currentScale * 100).round()}%', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)))])),
        ],
      ),
    );
  }
}
