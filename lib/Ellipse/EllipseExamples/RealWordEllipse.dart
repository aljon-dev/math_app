import 'package:flutter/material.dart';

class EllipseRealWorldScreen extends StatelessWidget {
  const EllipseRealWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child: Scaffold(
      appBar: AppBar(title: const Text('Real-world Ellipse Problems')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExampleCard(
              context,
              'Swimming Pool Design',
              'An elliptical pool is 26m long and 12m wide, centered at origin.',
              '1. 2a = 26 ⇒ a = 13\n'
                  '2. 2b = 12 ⇒ b = 6\n'
                  '3. Horizontal ellipse ⇒ x²/a² + y²/b² = 1\n'
                  '4. Equation: x²/169 + y²/36 = 1',
              'assets/pool_design.jpg',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Garden with Walkway',
              'Elliptical garden 24m long, 8m wide with 4m wide walkway.',
              '1. Original a = 12, b = 4\n'
                  '2. With walkway: a = 12+4 = 16, b = 4+4 = 8\n'
                  '3. Equation: x²/256 + y²/64 = 1',
              'assets/garden_walkway.jpg',
            ),
            const SizedBox(height: 20),
            _buildExampleCard(
              context,
              'Elliptical Tabletop',
              'Tabletop 180cm long, 100cm wide. Find distance between foci.',
              '1. 2a = 180 ⇒ a = 90\n'
                  '2. 2b = 100 ⇒ b = 50\n'
                  '3. c² = a² - b² = 8100 - 2500 = 5600\n'
                  '4. c ≈ 74.83 ⇒ Distance between foci ≈ 149.66cm',
              'assets/elliptical_table.jpg',
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
