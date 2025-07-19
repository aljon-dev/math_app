import 'package:flutter/material.dart';

class ParabolaRealWorldScreen extends StatelessWidget {
  const ParabolaRealWorldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Real Life Word Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Problem 1
            _buildProblem(
              context: context,
              problem: '1. A city is designing a new bridge with a parabolic arch. The shape of the arch is modeled by the equation: (x-3)² = -8(y-12) where x and y are measured in meters. Assuming the bottom of the arch touches the ground, what is the maximum height of the arch from the ground?',
              solution: [
                'Since we know that y = ax² + bx + c is the standard form of a downward parabola,',
                'In the given equation we are given the vertex of (0,12).',
                'Since the vertex is the highest point of the parabola, the answer is 12 meters.'
              ],
              image: 'assets/parabola_bridge_problem.png',
            ),
            const SizedBox(height: 24),

            // Problem 2
            _buildProblem(
              context: context,
              problem: '2. A decorative fountain in a park sprays water in the shape of a parabolic arc. The water reaches a maximum height of 4 meters and lands 6 meters away from where it started on the ground. Assuming the vertex of the parabola is at the highest point of the water arc and the fountain starts at the origin (0,0), find the equation of the parabola that models the path of the water.',
              solution: [
                'Standard form for downward parabola: (x - h)² = -4p(y - k)',
                'The length of the latus rectum is 6 meters (horizontal distance).',
                'Vertex is at midpoint: [(0+6)/2, 4] → (3,4)',
                'Substituting gives the equation: (x-3)² = -6(y-4)'
              ],
              image: 'assets/fountain_problem.jfif',
              finalAnswer: 'Final answer: (x-3)² = -6(y-4)',
            ),
            const SizedBox(height: 24),

            // Problem 3
            _buildProblem(
              context: context,
              problem: '3. During a baseball game, the ball is hit and follows a parabolic path that represents this equation: (x-20)² = -40(y-20). What is the length of the latus rectum of the parabola?',
              solution: [
                'Equation is in standard form: (x-h)² = -4p(y-k)',
                'Comparing with given equation: (x-20)² = -40(y-20)',
                '4p = 40 → p = 10',
                'Length of latus rectum = |4p| = 40 meters'
              ],
              image: 'assets/baseball.jfif',
              finalAnswer: 'Final answer: 40 meters',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProblem({
    required BuildContext context,
    required String problem,
    required List<String> solution,
    String? image,
    String? finalAnswer,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              problem,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            if (image != null) ...[
              const SizedBox(height: 12),
              _buildZoomableImage(context, image),
            ],
            const SizedBox(height: 12),
            const Text(
              'Solution:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...solution.map((step) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(step),
            )).toList(),
            if (finalAnswer != null) ...[
              const SizedBox(height: 12),
              Text(
                finalAnswer,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
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