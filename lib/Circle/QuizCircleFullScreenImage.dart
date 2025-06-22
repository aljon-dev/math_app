import 'package:flutter/material.dart';

class _FullScreenImageView extends StatefulWidget {
  final String imagePath;

  const _FullScreenImageView({required this.imagePath});

  @override
  _FullScreenImageViewState createState() => _FullScreenImageViewState();
}

class _FullScreenImageViewState extends State<_FullScreenImageView> {
  final TransformationController _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _controller.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Image Preview'), backgroundColor: Colors.black, iconTheme: IconThemeData(color: Colors.white), actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _resetZoom, tooltip: 'Reset Zoom')]), backgroundColor: Colors.black, body: Center(child: InteractiveViewer(transformationController: _controller, panEnabled: true, boundaryMargin: EdgeInsets.all(20.0), minScale: 0.1, maxScale: 10.0, child: Image.asset(widget.imagePath, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.white)))))));
  }
}
