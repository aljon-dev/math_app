import 'package:flutter/material.dart';

class RealLifeApplicationsScreen extends StatelessWidget {
  const RealLifeApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(title: const Text('Real-life Applications')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildExampleCard(
                context,
                'Analog Clocks',
                'Analog clocks utilize the circular path of their hands to represent the passage of time. '
                    'The face of the clock is a circle, and the hands move along circular paths with a common center. '
                    'The length of each hand represents a radius, and the circumference of the circular path is divided '
                    'into units representing hours, minutes, and seconds.',
                'assets/clock_example.png',
              ),
              const SizedBox(height: 20),
              _buildExampleCard(
                context,
                'Earthquake Location',
                'Seismologists use circles to determine and locate the center of earthquakes. '
                    'By measuring seismic waves from multiple locations, they can draw circles around '
                    'each observation point with radii equal to the estimated distance to the epicenter. '
                    'The intersection of these circles identifies the earthquake\'s location.',
                'assets/earthquake_example.png',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleCard(BuildContext context, String title, String content, String imagePath) {
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
                color: Colors.blue[800]
              ),
            ),
            const SizedBox(height: 12),
            Text(
              content, 
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 16, 
                height: 1.5
              ),
            ),
            if (imagePath.isNotEmpty) ...[
              const SizedBox(height: 16), 
              Center(
                child: _buildZoomableImage(context, imagePath),
              ),
            ],
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