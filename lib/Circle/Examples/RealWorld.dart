import 'package:flutter/material.dart';

class RealWorldProblemsScreen extends StatelessWidget {
  const RealWorldProblemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Real-world Problems')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProblemCard(
                context,
                'Ferris Wheel Problem',
                'A Ferris wheel is centered at (-8, 9) with radius 25 meters. '
                    'What is the standard form equation representing its circumference?',
                '1. Use standard form: (x - h)² + (y - k)² = r²\n'
                    '2. Substitute values:\n'
                    '   h = -8, k = 9, r = 25\n'
                    '3. Plug in:\n'
                    '   (x - (-8))² + (y - 9)² = 25²\n'
                    '4. Simplify:\n'
                    '   (x + 8)² + (y - 9)² = 625',
                'assets/ferris_wheel.png',
              ),
              const SizedBox(height: 20),
              _buildProblemCard(
                context,
                'Circular Garden Problem',
                'A garden boundary is represented by:\n'
                    'x² + y² + 10x - 4y - 71 = 0\n'
                    'Find the center and radius.',
                '1. Rewrite equation:\n'
                    '   x² + 10x + y² - 4y = 71\n'
                    '2. Complete the square:\n'
                    '   For x: (10/2)² = 25\n'
                    '   For y: (-4/2)² = 4\n'
                    '3. Add to both sides:\n'
                    '   x² + 10x + 25 + y² - 4y + 4 = 71 + 25 + 4\n'
                    '4. Rewrite:\n'
                    '   (x + 5)² + (y - 2)² = 100\n'
                    '5. Center: (-5, 2), Radius: 10',
                'assets/garden.png',
              ),
              const SizedBox(height: 20),
              _buildProblemCard(
                context,
                'Pizza Radius Problem',
                'A pizza\'s edge is represented by:\n'
                    '(x - 2)² + (y + 3)² = 16\n'
                    'What is the radius of the pizza?',
                '1. Compare with standard form:\n'
                    '   (x - h)² + (y - k)² = r²\n'
                    '2. Identify r² = 16 ⇒ r = √16 = 4\n'
                    '3. The pizza radius is 4 units',
                'assets/pizza.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProblemCard(BuildContext context, String title, String problem, String solution, String imagePath) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              problem,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                solution,
                style: const TextStyle(
                  fontSize: 15,
                  fontFamily: 'RobotoMono',
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: _buildZoomableImage(context, imagePath),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomableImage(BuildContext context, String imagePath) {
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
            width: 200,
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
    );
  }
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