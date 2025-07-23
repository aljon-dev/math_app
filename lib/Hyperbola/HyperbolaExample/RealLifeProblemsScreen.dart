import 'package:flutter/material.dart';

class HyperbolaRealWorldScreen extends StatelessWidget {
  const HyperbolaRealWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Real-world Hyperbola Problems')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProblem(problem: '1. A cooling tower is shaped like a hyperbola that can be modeled by x²/25 - y²/256 = 1. What is the width of the tower at its narrowest part in the middle?', solution: ['Given: a² = 25 → a = 5', 'The narrowest part is the length of the transverse axis: 2a', 'Solution: 2(5) = 10', 'Answer: The narrowest part is 10 meters.'], context: context, image: 'assets/images/hyperbola_cooling_tower_problem.png'),
              const SizedBox(height: 24),
              _buildProblem(problem: '2. A cooling tower stands 195 meters tall. The diameter of the top is 82 meters. At their closest, the sides are 50 meters apart. Find the equation of the hyperbola that models the sides.', solution: ['Given:', '2a = 50 → a = 25 → a² = 625', 'Top radius = 82/2 = 41m', 'Height to top = 95m (from center)', 'Using point (41, 95) on hyperbola:', 'b² = y² / (x²/a² - 1) = 95² / (41²/25² - 1) ≈ 5341.50', 'Final equation: x²/625 - y²/5341.50 = 1'], context: context, image: 'assets/images/hyperbola_cooling_tower_equation.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProblem({required String problem, required List<String> solution, required BuildContext context, String? image}) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(problem, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (image != null) ...[_buildZoomableImage(image, context), const SizedBox(height: 8)],
            const Text('Solution:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...solution.map((step) => Padding(padding: const EdgeInsets.symmetric(vertical: 4.0), child: Text(step))).toList(),
          ],
        ),
      ),
    );
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
