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
              _buildZoomableImage('assets/images/guitar.jpg',context),
              const SizedBox(height: 10,),
              Text('GUITAR',style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              )),
              _buildExampleItem('The curved waist of a guitar mimics the two opposing branches of a hyperbola: each side slopes inward toward a narrow middle before flaring outward, creating a symmetrical, flowing form. This shape isn’t merely aesthetic, it allows the instrument to rest comfortably against the player’s body, ensures balanced ergonomics, and enables a guitarist to reach frets and strings more easily. As a result, the guitar’s design beautifully blends mathematical elegance with functional comfort and acoustical balance.'),
                   const Divider(),
                const SizedBox(height: 15,),
              _buildZoomableImage('assets/images/KoberportTower.jpg',context),
              const SizedBox(height: 10,),
              Text('KOBE PORT TOWER',style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              )),

               _buildExampleItem('Kobe Port Tower is a striking real-world embodiment of a hyperbola through its hyperboloid form: its steel lattice curves inward at the waist and flares outward at top and bottom, tracing the two mirrored branches of a hyperbola spun around a vertical axis. This shape isn’t just visually pleasing, it offers remarkable structural strength and stability by distributing loads efficiently and allowing construction from straight steel beams. Engineers chose this hyperbolic geometry because it uses less material than other forms for a given height and width. Completed in 1963, the tower seamlessly blends mathematical elegance, earthquake‑resistant engineering, economical efficiency, and cultural flair, its hourglass silhouette reminiscent of the traditional Japanese tsuzumi drum.'),
                const Divider(),
                const SizedBox(height: 15,),

              _buildZoomableImage('assets/images/Coolingtowers.jpg',context),

               const SizedBox(height: 10,),
              Text('COOLING TOWERS',style:TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              )),



          
              _buildExampleItem('Cooling towers at power plants are a vivid, real-world example of hyperbolas in three dimensions. Their iconic shape, a graceful narrowing in the middle and widening at the base and top, forms a hyperboloid of one sheet, created by rotating a hyperbola around its vertical axis. This isn’t mere aesthetics: the inward curve strengthens the structure with less material, and it boosts airflow via the natural “chimney” or Venturi effect drawing cool air in at the bottom and expelling warm, moist air at the top, all without fans . The hyperbolic design also makes the tower highly resistant to wind loads while facilitating efficient vapor diffusion at the top. In essence, cooling towers masterfully transform the elegant mathematics of hyperbolas into practical engineering, merging structural economy, aerodynamic efficiency, and visual grandeur.'),
             
             
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
          Text(text,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14
            
          ),), 
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