import 'package:flutter/material.dart';

class EllipseFromGraphScreen extends StatelessWidget {
  const EllipseFromGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child:  Scaffold(
      appBar: AppBar(title: const Text('Ellipse from Graphs')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExampleCard(
              context,
              'Example 1',
              'Graph with center at (3,-1), a=3, b=2 (vertical)',
              '1. Identify center: (3,-1)\n'
                  '2. Identify a=3, b=2\n'
                  '3. Standard form: (x-3)²/4 + (y+1)²/9 = 1',
              'assets/ellipse_graph1.jpg',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Example 2',
              'Graph with center at (-4,2), a=5, b=4 (horizontal)',
              '1. Identify center: (-4,2)\n'
                  '2. Identify a=5, b=4\n'
                  '3. Standard form: (x+4)²/25 + (y-2)²/16 = 1',
              'assets/ellipse_graph2.jpg',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Find Coordinates (Example 1)',
              'Graph with center at (6,-4), vertices at (-3,-4) and (15,-4)',
              '1. Center: (6,-4)\n'
                  '2. Vertices: (-3,-4) and (15,-4)\n'
                  '3. Co-vertices: (6,1) and (6,-9)',
              'assets/ellipse_graph3.jpg',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Find Coordinates (Example 2)',
              'Graph with center at (-4,7), vertices at (-4,17) and (-4,-3)',
              '1. Center: (-4,7)\n'
                  '2. Vertices: (-4,17) and (-4,-3)\n'
                  '3. Co-vertices: (-10,7) and (2,7)',
              'assets/ellipse_graph4.jpg',
            ),
          ],
        ),
      ),
    ));
  }

 Widget _buildExampleCard(BuildContext context, String title, String problem, 
      String solution, String imagePath) {
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
                color: Colors.teal[800],
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
                problem,
                style: const TextStyle(fontSize: 16, fontFamily: 'RobotoMono'),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Steps:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              solution,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                height: 1.5,
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
