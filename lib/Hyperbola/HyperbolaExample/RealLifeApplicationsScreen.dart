import 'package:flutter/material.dart';

class HyperbolaIntroScreen extends StatelessWidget {
  const HyperbolaIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(child: Scaffold(appBar: AppBar(title: const Text('Real-life Hyperbola Examples')), body: SingleChildScrollView(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildExampleCard(context, 'Guitar Design', 'The curved waist of a guitar mimics the two opposing branches of a hyperbola, creating a symmetrical, flowing form that blends mathematical elegance with functional comfort.', '1. The hyperbolic shape allows the instrument to rest comfortably against the player\'s body\n2. Ensures balanced ergonomics for playing\n3. Enables easier reach of frets and strings\n4. Provides acoustical balance and aesthetic appeal', 'assets/images/guitar.jpg'), const SizedBox(height: 20), _buildExampleCard(context, 'Kobe Port Tower', 'This tower embodies a hyperbola through its hyperboloid form, with steel lattice curving inward at the waist and flaring outward at top and bottom.', '1. Offers remarkable structural strength and stability\n2. Distributes loads efficiently\n3. Uses less material than other forms\n4. Blends mathematical elegance with earthquake-resistant engineering\n5. Inspired by traditional Japanese tsuzumi drum design', 'assets/images/KoberportTower.jpg'), const SizedBox(height: 20), _buildExampleCard(context, 'Cooling Towers', 'These iconic structures form a hyperboloid of one sheet, created by rotating a hyperbola around its vertical axis.', '1. Inward curve strengthens structure with less material\n2. Boosts airflow via natural "chimney" effect\n3. Highly resistant to wind loads\n4. Facilitates efficient vapor diffusion\n5. Combines structural economy with aerodynamic efficiency', 'assets/images/Coolingtowers.jpg')]))));
  }

  Widget _buildExampleCard(BuildContext context, String title, String problem, String solution, String imagePath) {
    return Card(elevation: 3, margin: const EdgeInsets.only(bottom: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), child: Padding(padding: const EdgeInsets.all(16.0), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.black)), const SizedBox(height: 12), Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)), child: Text(problem, style: const TextStyle(fontSize: 16, fontFamily: 'RobotoMono'))), const SizedBox(height: 12), Text('Key Features:', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(solution, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.5)), const SizedBox(height: 12), Center(child: _buildZoomableImage(context, imagePath))])));
  }

  Widget _buildZoomableImage(BuildContext context, String imagePath) {
    return SizedBox(
      height: 250,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => _ZoomableImageScreen(imagePath: imagePath)));
        },
        child: Hero(tag: 'image-$imagePath', child: Image.asset(imagePath, width: 250, height: 250, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey))))),
      ),
    );
  }
}

// Keep the same _ZoomableImageScreen implementation
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
      appBar: AppBar(title: const Text('Image Preview'), actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _resetZoom, tooltip: 'Reset Zoom')]),
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
          Positioned(right: 16, bottom: 100, child: Column(children: [FloatingActionButton(mini: true, onPressed: _currentScale < _maxScale ? _zoomIn : null, child: const Icon(Icons.zoom_in), backgroundColor: _currentScale < _maxScale ? Theme.of(context).primaryColor : Colors.grey), const SizedBox(height: 8), FloatingActionButton(mini: true, onPressed: _currentScale > _minScale ? _zoomOut : null, child: const Icon(Icons.zoom_out), backgroundColor: _currentScale > _minScale ? Theme.of(context).primaryColor : Colors.grey), const SizedBox(height: 8), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)), child: Text('${(_currentScale * 100).round()}%', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)))])),
        ],
      ),
    );
  }
}
