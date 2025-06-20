import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:math_app/Menu.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

class ConicSectionVisualization extends StatefulWidget {
  const ConicSectionVisualization({Key? key}) : super(key: key);

  @override
  State<ConicSectionVisualization> createState() => _ConicSectionVisualizationState();
}

class _ConicSectionVisualizationState extends State<ConicSectionVisualization> with TickerProviderStateMixin {
  // Conic section type
  String _currentType = "Circle";

  // Control parameters
  double _planeAngle = 0.0; // Angle of the cutting plane
  double _horizontalRotation = 0.0; // Horizontal rotation of the view
  double _verticalPosition = 0.0; // Vertical position of the cutting plane

  // Animation controller for rotation
  late AnimationController _animationController;
  bool _isAnimating = false;

  // Gesture control variables
  double _lastPanX = 0;
  double _lastPanY = 0;

  // Control zoom Parameters
  double _zoomLevel = 1.0;
  double _baseZoomLevel = 1.0;
  final double _minZoom = 0.5;
  final double _maxZoom = 3.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..addListener(() {
      setState(() {
        _horizontalRotation = _animationController.value * 2 * math.pi;
      });
    });
    _updateConicType();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleAnimation() {
    setState(() {
      if (_isAnimating) {
        _animationController.stop();
      } else {
        _animationController.repeat();
      }
      _isAnimating = !_isAnimating;
    });
  }

  void _updateConicType() {
    // Determine the type of conic section based on the angle
    if (_planeAngle < 0.1) {
      _currentType = "Circle";
    } else if (_planeAngle < 0.9) {
      // Changed from 0.7 to 0.5
      _currentType = "Ellipse";
    } else if (_planeAngle < 1.19) {
      // Changed from 1.2 to 0.9
      _currentType = "Parabola";
    } else {
      _currentType = "Hyperbola";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CONIC SECTION: $_currentType'), actions: [IconButton(icon: Icon(_isAnimating ? Icons.pause : Icons.play_arrow), onPressed: _toggleAnimation)]),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            _currentType,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color:
                  _currentType == 'Circle'
                      ? Colors.red
                      : _currentType == 'Ellipse'
                      ? Colors.orange
                      : _currentType == 'Parabola'
                      ? Colors.green
                      : _currentType == 'Hyperbola'
                      ? Colors.blue
                      : Colors.black,
            ),
          ),
          Expanded(
            flex: 3,
            child: // Replace your existing GestureDetector with this fixed version:
                GestureDetector(
              onScaleStart: (details) {
                _lastPanX = details.localFocalPoint.dx;
                _lastPanY = details.localFocalPoint.dy;
                _baseZoomLevel = _zoomLevel;
              },
              onScaleUpdate: (details) {
                setState(() {
                  // Handle rotation (pan gesture)
                  final dx = details.localFocalPoint.dx - _lastPanX;
                  final dy = details.localFocalPoint.dy - _lastPanY;

                  // Only apply rotation if it's primarily a single finger drag
                  if (details.scale == 1.0) {
                    _horizontalRotation += dx * 0.01;
                    _planeAngle = (_planeAngle - dy * 0.01).clamp(0, math.pi / 2);
                    _updateConicType();
                  }

                  // Handle zoom (pinch gesture)
                  _zoomLevel = (_baseZoomLevel * details.scale).clamp(_minZoom, _maxZoom);

                  _lastPanX = details.localFocalPoint.dx;
                  _lastPanY = details.localFocalPoint.dy;
                });
              },
              child: CustomPaint(painter: ConicSectionPainter(planeAngle: _planeAngle, horizontalRotation: _horizontalRotation, verticalPosition: _verticalPosition, zoomLevel: _zoomLevel), child: Container()),
            ),
          ),
          Divider(),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButton()));
                        },
                        child: Text('Skip'),
                      ),
                    ),
                    _buildSlider("Left and Right", _horizontalRotation, 0, 2 * math.pi, (value) {
                      setState(() {
                        _horizontalRotation = value;
                      });
                    }),
                    _buildSlider("Up and Down", _verticalPosition, -0.5, 0.5, (value) {
                      setState(() {
                        _verticalPosition = value;
                      });
                    }),
                    _buildSlider("Change Angle", _planeAngle, 0, math.pi / 2, (value) {
                      setState(() {
                        _planeAngle = value;
                        _updateConicType();
                      });
                    }),
                    _buildSlider("Zoom", _zoomLevel, _minZoom, _maxZoom, (value) {
                      setState(() {
                        _zoomLevel = value;
                      });
                    }),

                    Text(_planeAngle.toString()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String label, double value, double min, double max, Function(double) onChanged) {
    return Row(
      children: [
        SizedBox(width: 100, child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold))),
        Expanded(
          child: Slider(
            value: value.clamp(min, max), // Clamp the value to ensure it's within bounds
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class ConicSectionPainter extends CustomPainter {
  final double planeAngle;
  final double horizontalRotation;
  final double verticalPosition;
  final double zoomLevel;

  // Constants
  final double _coneHeight = 2.0;
  final double _coneRadius = 1.0;

  ConicSectionPainter({
    required this.planeAngle,
    required this.horizontalRotation,
    required this.verticalPosition,
    required this.zoomLevel, // Add this
  });

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = math.min(size.width, size.height) * 0.3;

    // Create a 3D scene
    final scene = _createScene(scale);

    // Project 3D vertices to 2D
    final projectedVertices = _projectVertices(scene, centerX, centerY, scale);

    _drawCartesianGrid(canvas, size);

    // Draw the upside-down cone (upper cone)
    _drawUpperCone(canvas, projectedVertices);

    // Draw the regular cone (lower cone)
    _drawLowerCone(canvas, projectedVertices);

    // Draw the conic section
    _drawCombinedPlaneAndConic(canvas, size, projectedVertices);
  }

  List<vector_math.Vector3> _createScene(double scale) {
    final List<vector_math.Vector3> vertices = [];

    // Common apex (center point where cones meet)
    vertices.add(vector_math.Vector3(0, 0, 0));

    // Upper cone base circle vertices
    final segments = 36;
    for (int i = 0; i <= segments; i++) {
      final angle = i * (2 * math.pi / segments);
      final x = _coneRadius * math.cos(angle);
      final z = _coneRadius * math.sin(angle);
      vertices.add(vector_math.Vector3(x, _coneHeight, z));
    }

    // Lower cone base circle vertices
    for (int i = 0; i <= segments; i++) {
      final angle = i * (2 * math.pi / segments);
      final x = _coneRadius * math.cos(angle);
      final z = _coneRadius * math.sin(angle);
      vertices.add(vector_math.Vector3(x, -_coneHeight, z));
    }

    // CRITICAL: Use consistent plane transformation
    // Adjust plane size based on zoom level
    final planeWidth = _coneRadius * 2.5 * (1 + (zoomLevel - 1) * 0.5);
    final planeVertices2D = [vector_math.Vector3(-planeWidth, 0, -planeWidth), vector_math.Vector3(planeWidth, 0, -planeWidth), vector_math.Vector3(planeWidth, 0, planeWidth), vector_math.Vector3(-planeWidth, 0, planeWidth)];

    // Apply transformation
    final rotationMatrix = vector_math.Matrix4.rotationX(planeAngle);
    rotationMatrix.translate(0.0, verticalPosition * _coneHeight, 0.0);

    // Scale the plane position based on zoom
    final planeScale = 1.0 + (zoomLevel - 1) * 0.3;
    final scaleMatrix = vector_math.Matrix4.identity();
    scaleMatrix.scale(planeScale, planeScale, planeScale);

    for (final vertex in planeVertices2D) {
      vertices.add((rotationMatrix * scaleMatrix).transformed3(vertex));
    }

    return vertices;
  }

  List<Offset> _projectVertices(List<vector_math.Vector3> vertices, double centerX, double centerY, double scale) {
    // Stabilize zoom factor to prevent extreme distortion
    final zoomFactor = math.pow(zoomLevel.clamp(0.5, 2.0), 1.2).toDouble();

    // Keep camera at reasonable distance
    final cameraDistance = (4.0 / zoomFactor).clamp(2.0, 8.0);
    final cameraPosition = vector_math.Vector3(0, 0, cameraDistance);
    final cameraLookAt = vector_math.Vector3(0, 0, 0);
    final cameraUp = vector_math.Vector3(0, 1, 0);

    // Apply moderate zoom to scale, not extreme
    final adjustedScale = scale * (1.0 + (zoomLevel - 1.0) * 0.5);

    // Compute view matrix
    final viewMatrix = vector_math.makeViewMatrix(cameraPosition, cameraLookAt, cameraUp);

    // Use consistent FOV to prevent distortion
    final fov = (50 * math.pi / 180).clamp(30 * math.pi / 180, 70 * math.pi / 180);
    final projectionMatrix = vector_math.makePerspectiveMatrix(fov, 1.0, 0.1, 100.0);

    // Compute model matrix (rotate the scene)
    final modelMatrix = vector_math.Matrix4.rotationY(horizontalRotation);

    // Compute MVP matrix
    final mvpMatrix = projectionMatrix * viewMatrix * modelMatrix;

    // Project 3D vertices to 2D screen space
    return vertices.map((v) {
      final projected = mvpMatrix.transformed3(v);

      // Add safety check for perspective division
      final z = math.max(projected.z, 0.01); // Prevent division by zero or negative
      final x = projected.x / z;
      final y = projected.y / z;

      // Clamp values to prevent extreme coordinates
      final clampedX = x.clamp(-10.0, 10.0);
      final clampedY = y.clamp(-10.0, 10.0);

      return Offset(centerX + clampedX * adjustedScale, centerY - clampedY * adjustedScale);
    }).toList();
  }

  void _drawCartesianGrid(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final gridPaint =
        Paint()
          ..color = Colors.grey.withOpacity(0.3)
          ..strokeWidth = 1.0;

    final axisPaint =
        Paint()
          ..color = Colors.black.withOpacity(0.7)
          ..strokeWidth = 2.0;

    // Stabilize font size scaling
    final fontSize = (12 * zoomLevel.clamp(0.8, 1.3)).clamp(10.0, 16.0);
    final labelStyle = TextStyle(color: Colors.black87, fontSize: fontSize, fontWeight: FontWeight.w500);

    // Prevent grid from becoming too dense or sparse
    final baseSpacing = 40.0;
    final gridSpacing = (baseSpacing / zoomLevel.clamp(0.7, 1.5)).clamp(20.0, 80.0);
    final maxGridLines = (8 * zoomLevel.clamp(0.8, 1.5)).round().clamp(6, 12);

    // Draw grid lines with controlled density
    for (int i = -maxGridLines; i <= maxGridLines; i++) {
      if (i == 0) continue;

      final offset = i * gridSpacing;

      // Vertical grid lines
      final x = centerX + offset;
      if (x >= 0 && x <= size.width) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);

        // Only show labels when zoom is reasonable
        if (zoomLevel > 0.8 && zoomLevel < 2.0) {
          final textPainter = TextPainter(textDirection: TextDirection.ltr, text: TextSpan(text: '${i.abs()}', style: labelStyle));
          textPainter.layout();
          textPainter.paint(canvas, Offset(x - textPainter.width / 2, centerY + 5));
        }
      }

      // Horizontal grid lines
      final y = centerY + offset;
      if (y >= 0 && y <= size.height) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);

        if (zoomLevel > 0.8 && zoomLevel < 2.0) {
          final textPainter = TextPainter(textDirection: TextDirection.ltr, text: TextSpan(text: '${i.abs()}', style: labelStyle));
          textPainter.layout();
          textPainter.paint(canvas, Offset(centerX + 5, y - textPainter.height / 2));
        }
      }
    }

    // Draw main axes
    canvas.drawLine(Offset(0, centerY), Offset(size.width, centerY), axisPaint);
    canvas.drawLine(Offset(centerX, 0), Offset(centerX, size.height), axisPaint);

    // Add axis labels with controlled size
    final axisLabelStyle = labelStyle.copyWith(fontSize: (fontSize * 1.2).clamp(12.0, 18.0), fontWeight: FontWeight.bold);

    final textPainter = TextPainter(textDirection: TextDirection.ltr);

    // X-axis label
    textPainter.text = TextSpan(text: 'X', style: axisLabelStyle);
    textPainter.layout();
    textPainter.paint(canvas, Offset(size.width - 20, centerY + 5));

    // Y-axis label
    textPainter.text = TextSpan(text: 'Y', style: axisLabelStyle);
    textPainter.layout();
    textPainter.paint(canvas, Offset(centerX + 5, 15));

    // Origin label
    textPainter.text = TextSpan(text: '0', style: labelStyle);
    textPainter.layout();
    textPainter.paint(canvas, Offset(centerX + 5, centerY + 5));
  }

  // 2. Update the _projectVertices method to apply zoom

  void _drawUpperCone(Canvas canvas, List<Offset> projectedVertices) {
    // Create gradient for upper cone
    final upperConePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..shader = LinearGradient(colors: [Colors.purple, Colors.deepPurple], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromPoints(projectedVertices[0], projectedVertices[1]));

    // Shadow paint for 3D effect
    final shadowPaint =
        Paint()
          ..color = Colors.black.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);

    // Draw upper cone surface (simplified representation)
    final surfacePath = Path();
    final apex = projectedVertices[0];

    // Draw upper cone edges with gradient effect (upside down)
    for (int i = 1; i <= 36; i += 3) {
      // Draw shadow for 3D effect
      canvas.drawLine(apex, projectedVertices[i], shadowPaint);
      // Draw actual line with gradient
      canvas.drawLine(apex, projectedVertices[i], upperConePaint);

      // Add to surface path
      if (i == 1) {
        surfacePath.moveTo(apex.dx, apex.dy);
        surfacePath.lineTo(projectedVertices[i].dx, projectedVertices[i].dy);
      } else if (i % 12 == 1) {
        surfacePath.lineTo(apex.dx, apex.dy);
        surfacePath.lineTo(projectedVertices[i].dx, projectedVertices[i].dy);
      }
    }

    // Draw upper base circle with gradient
    final upperBasePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..shader = SweepGradient(colors: [Colors.purple, Colors.blue, Colors.purple], startAngle: 0, endAngle: 2 * math.pi).createShader(Rect.fromCircle(center: projectedVertices[0], radius: (projectedVertices[1] - projectedVertices[0]).distance));

    final path = Path();
    path.moveTo(projectedVertices[1].dx, projectedVertices[1].dy);
    for (int i = 2; i <= 36; i++) {
      path.lineTo(projectedVertices[i].dx, projectedVertices[i].dy);
    }
    path.close();

    // Draw shadow for 3D effect
    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, upperBasePaint);

    final fillPaint =
        Paint()
          ..shader = RadialGradient(colors: [Colors.purple.withOpacity(0.8), Colors.deepPurple.withOpacity(0.6)], stops: [0.0, 1.0]).createShader(Rect.fromCircle(center: apex, radius: 200))
          ..style = PaintingStyle.fill;

    // Create triangular faces for the cone surface
    for (int i = 1; i < 37; i++) {
      final trianglePath =
          Path()
            ..moveTo(apex.dx, apex.dy)
            ..lineTo(projectedVertices[i].dx, projectedVertices[i].dy)
            ..lineTo(projectedVertices[i + 1].dx, projectedVertices[i + 1].dy)
            ..close();
      canvas.drawPath(trianglePath, fillPaint);
    }
    ;
  }

  void _drawLowerCone(Canvas canvas, List<Offset> projectedVertices) {
    // Create gradient for lower cone
    final lowerConePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..shader = LinearGradient(colors: [Colors.blue, Colors.teal], begin: Alignment.topCenter, end: Alignment.bottomCenter).createShader(Rect.fromPoints(projectedVertices[0], projectedVertices[38]));

    // Shadow paint for 3D effect
    final shadowPaint =
        Paint()
          ..color = Colors.black.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3);

    // Draw lower cone surface (simplified representation)
    final surfacePath = Path();
    final apex = projectedVertices[0];

    // Draw lower cone edges with gradient effect
    for (int i = 38; i <= 73; i += 3) {
      // Draw shadow for 3D effect
      canvas.drawLine(apex, projectedVertices[i], shadowPaint);
      // Draw actual line with gradient
      canvas.drawLine(apex, projectedVertices[i], lowerConePaint);

      // Add to surface path
      if (i == 38) {
        surfacePath.moveTo(apex.dx, apex.dy);
        surfacePath.lineTo(projectedVertices[i].dx, projectedVertices[i].dy);
      } else if ((i - 38) % 12 == 0) {
        surfacePath.lineTo(apex.dx, apex.dy);
        surfacePath.lineTo(projectedVertices[i].dx, projectedVertices[i].dy);
      }
    }

    // Draw lower base circle with gradient
    final lowerBasePaint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..shader = SweepGradient(colors: [Colors.teal, Colors.cyan, Colors.teal], startAngle: 0, endAngle: 2 * math.pi).createShader(Rect.fromCircle(center: projectedVertices[0], radius: (projectedVertices[38] - projectedVertices[0]).distance));

    final path = Path();
    path.moveTo(projectedVertices[38].dx, projectedVertices[38].dy);
    for (int i = 39; i <= 73; i++) {
      path.lineTo(projectedVertices[i].dx, projectedVertices[i].dy);
    }
    path.close();

    // Draw shadow for 3D effect
    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, lowerBasePaint);

    final fillPaint =
        Paint()
          ..shader = RadialGradient(colors: [Colors.blue.withOpacity(0.6), Colors.teal], stops: [0.0, 1.0]).createShader(Rect.fromCircle(center: apex, radius: 200))
          ..style = PaintingStyle.fill;

    // Triangular faces for thje cone surface

    for (int i = 38; i < 74; i++) {
      final trianglePath =
          Path()
            ..moveTo(apex.dx, apex.dy)
            ..lineTo(projectedVertices[i].dx, projectedVertices[i].dy)
            ..lineTo(projectedVertices[i + 1].dx, projectedVertices[i + 1].dy)
            ..close();

      canvas.drawPath(trianglePath, fillPaint);
    }
  }

  void _drawCombinedPlaneAndConic(Canvas canvas, Size size, List<Offset> projectedVertices) {
    final planeAlpha = (0.3 / zoomLevel).clamp(0.15, 0.5);
    final planePaint =
        Paint()
          ..color = Colors.lightBlue.withOpacity(planeAlpha)
          ..style = PaintingStyle.fill;

    final planeOutlinePaint =
        Paint()
          ..color = const Color.fromARGB(255, 213, 9, 37)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5 * zoomLevel.clamp(0.8, 1.5);

    final planeVertices = projectedVertices.sublist(projectedVertices.length - 4);
    final planePath =
        Path()
          ..moveTo(planeVertices[0].dx, planeVertices[0].dy)
          ..lineTo(planeVertices[1].dx, planeVertices[1].dy)
          ..lineTo(planeVertices[2].dx, planeVertices[2].dy)
          ..lineTo(planeVertices[3].dx, planeVertices[3].dy)
          ..close();

    canvas.drawPath(planePath, planePaint);
    canvas.drawPath(planePath, planeOutlinePaint);

    // Determine the current conic type based on plane angle
    String currentType = _getCurrentConicType();

    final conicStrokeWidth = 3.0 * zoomLevel.clamp(0.8, 1.5);
    // Draw the conic section with dynamic color
    final conicPaint =
        Paint()
          ..color = _getConicColor(currentType)
          ..style = PaintingStyle.stroke
          ..strokeWidth = conicStrokeWidth;

    // For hyperbola case, we need to draw both branches
    if (planeAngle > 1.19) {
      // Upper branch (from upper cone)
      final upperPoints = _calculateIntersectionPoints(size: size, upperCone: true);
      if (upperPoints.isNotEmpty) {
        final upperPath = Path()..moveTo(upperPoints[0].dx, upperPoints[0].dy);
        for (int i = 1; i < upperPoints.length; i++) {
          upperPath.lineTo(upperPoints[i].dx, upperPoints[i].dy);
        }
        canvas.drawPath(upperPath, conicPaint);
      }

      // Lower branch (from lower cone)
      final lowerPoints = _calculateIntersectionPoints(size: size, upperCone: false);
      if (lowerPoints.isNotEmpty) {
        final lowerPath = Path()..moveTo(lowerPoints[0].dx, lowerPoints[0].dy);
        for (int i = 1; i < lowerPoints.length; i++) {
          lowerPath.lineTo(lowerPoints[i].dx, lowerPoints[i].dy);
        }
        canvas.drawPath(lowerPath, conicPaint);
      }
    } else {
      // Normal case (circle/ellipse/parabola)
      // FIX: Determine which cone to use based on vertical position
      final planeY = verticalPosition * _coneHeight;
      final useUpperCone = planeY >= 0;

      final points = _calculateIntersectionPoints(size: size, upperCone: useUpperCone);
      if (points.isNotEmpty) {
        final path = Path()..moveTo(points[0].dx, points[0].dy);
        for (int i = 1; i < points.length; i++) {
          path.lineTo(points[i].dx, points[i].dy);
        }
        if (planeAngle < 0.9) path.close(); // Close for circles/ellipses
        canvas.drawPath(path, conicPaint);
      }
    }
  }

  // NEW: Determine current conic type based on plane angle
  String _getCurrentConicType() {
    if (planeAngle < 0.1) {
      return 'Circle';
    } else if (planeAngle < 1.0) {
      // Changed from 0.8 to match _updateConicType
      return 'Ellipse';
    } else if (planeAngle < 1.19) {
      // Changed from 0.17 to match _updateConicType
      return 'Parabola';
    } else {
      return 'Hyperbola';
    }
  }

  // NEW: Get color based on conic type
  Color _getConicColor(String conicType) {
    switch (conicType) {
      case 'Circle':
        return Colors.red;
      case 'Ellipse':
        return Colors.orange;
      case 'Parabola':
        return Colors.green;
      case 'Hyperbola':
        return Colors.blue;
      default:
        return Colors.red;
    }
  }

  List<Offset> _calculateIntersectionPoints({required Size size, required bool upperCone}) {
    final List<vector_math.Vector3> intersectionPoints = [];
    final segments = 100;

    // IMPORTANT: Use the same plane transformation as used for drawing the plane
    final planeWidth = _coneRadius * 3.5;
    final planeVertices = [vector_math.Vector3(-planeWidth, 0, -planeWidth), vector_math.Vector3(planeWidth, 0, -planeWidth), vector_math.Vector3(planeWidth, 0, planeWidth), vector_math.Vector3(-planeWidth, 0, planeWidth)];

    // Apply the SAME transformation used for the plane
    final rotationMatrix = vector_math.Matrix4.rotationX(planeAngle);
    rotationMatrix.translate(0.0, verticalPosition * _coneHeight, 0.0);

    // Get the transformed plane center and normal
    final planeCenter = rotationMatrix.transformed3(vector_math.Vector3(0, 0, 0));
    final planeNormal = rotationMatrix.transformed3(vector_math.Vector3(0, 1, 0)) - rotationMatrix.transformed3(vector_math.Vector3(0, 0, 0));
    planeNormal.normalize();

    // Cone parameters
    final coneSlope = _coneRadius / _coneHeight;
    final apex = vector_math.Vector3(0, 0, 0);
    final halfAngle = math.atan(coneSlope);

    for (int i = 0; i <= segments; i++) {
      final theta = 2 * math.pi * i / segments;

      // Generate rays from apex along the cone surface
      vector_math.Vector3 rayDirection;
      if (upperCone) {
        rayDirection = vector_math.Vector3(math.sin(halfAngle) * math.cos(theta), math.cos(halfAngle), math.sin(halfAngle) * math.sin(theta));
      } else {
        rayDirection = vector_math.Vector3(math.sin(halfAngle) * math.cos(theta), -math.cos(halfAngle), math.sin(halfAngle) * math.sin(theta));
      }

      // Find intersection of cone ray with plane
      final denom = planeNormal.dot(rayDirection);
      if (denom.abs() > 1e-6) {
        final t = planeNormal.dot(planeCenter - apex) / denom;
        if (t > 0) {
          final intersectionPoint = apex + rayDirection * t;

          // Validate that the intersection is within reasonable cone bounds
          final heightLimit = upperCone ? _coneHeight * 1.5 : -_coneHeight * 1.5;
          if (upperCone ? intersectionPoint.y <= heightLimit : intersectionPoint.y >= heightLimit) {
            intersectionPoints.add(intersectionPoint);
          }
        }
      }
    }

    // Project to 2D screen coordinates
    if (intersectionPoints.isNotEmpty) {
      final centerX = size.width / 2;
      final centerY = size.height / 2;
      final scale = math.min(size.width, size.height) * 0.3;

      final projected = _projectVertices(intersectionPoints, centerX, centerY, scale);

      // Sort by angle for proper path drawing
      if (projected.length > 2) {
        final center = projected.fold<Offset>(Offset.zero, (sum, point) => Offset(sum.dx + point.dx, sum.dy + point.dy)) / projected.length.toDouble();

        projected.sort((a, b) {
          final angleA = math.atan2(a.dy - center.dy, a.dx - center.dx);
          final angleB = math.atan2(b.dy - center.dy, b.dx - center.dx);
          return angleA.compareTo(angleB);
        });
      }

      return projected;
    }

    return [];
  }

  // Helper: Get average point of a list of vertices
  vector_math.Vector3 _getAveragePoint(List<Offset> vertices) {
    double x = 0, y = 0;
    for (final vertex in vertices) {
      x += vertex.dx;
      y += vertex.dy;
    }
    return vector_math.Vector3(
      x / vertices.length,
      y / vertices.length,
      0, // Approximate Z (simplified)
    );
  }

  // Helper: Compute plane normal from 3 vertices
  vector_math.Vector3 _getPlaneNormal(List<Offset> vertices) {
    final v1 = vector_math.Vector3(vertices[1].dx - vertices[0].dx, vertices[1].dy - vertices[0].dy, 0);
    final v2 = vector_math.Vector3(vertices[2].dx - vertices[0].dx, vertices[2].dy - vertices[0].dy, 0);
    return v1.cross(v2).normalized();
  }

  // Helper: Line-plane intersection
  vector_math.Vector3? _linePlaneIntersection(vector_math.Vector3 linePoint, vector_math.Vector3 lineDir, vector_math.Vector3 planeNormal, vector_math.Vector3 planePoint) {
    final denom = planeNormal.dot(lineDir);
    if (denom.abs() < 1e-6) return null; // Parallel or no intersection

    final t = planeNormal.dot(planePoint - linePoint) / denom;
    return linePoint + lineDir * t;
  }

  // Helper: Project 3D point to 2D screen space
  Offset _projectPoint(vector_math.Vector3 point) {
    // Simplified projection (adjust based on your camera setup)
    return Offset(
      point.x * 100 + 50, // Adjust scale/offset as needed
      -point.y * 100 + 50, // Flip Y for screen coordinates
    );
  }

  vector_math.Vector3 _calculateConicSectionCenter() {
    // This is a simplified calculation
    final y = verticalPosition * _coneHeight;
    return vector_math.Vector3(0, y, 0);
  }

  vector_math.Vector2 _calculateConicSectionDimensions() {
    // Calculate the dimensions of the conic section based on the angle
    final y = verticalPosition * _coneHeight;
    final radiusAtY = _coneRadius * (1 - (math.cos(y) / _coneHeight));

    double majorAxis;
    double minorAxis;

    final currentType = _getCurrentConicType();

    if (currentType == 'Circle') {
      majorAxis = radiusAtY;
      minorAxis = radiusAtY;
    } else if (currentType == 'Ellipse') {
      majorAxis = radiusAtY / math.cos(planeAngle);
      minorAxis = radiusAtY;
    } else if (currentType == 'Parabola') {
      majorAxis = radiusAtY * 1.5;
      minorAxis = radiusAtY * 1.5;
    } else {
      // Hyperbola
      majorAxis = radiusAtY * 2;
      minorAxis = radiusAtY;
    }

    return vector_math.Vector2(majorAxis, minorAxis);
  }

  @override
  bool shouldRepaint(ConicSectionPainter oldDelegate) {
    return oldDelegate.planeAngle != planeAngle || oldDelegate.horizontalRotation != horizontalRotation || oldDelegate.verticalPosition != verticalPosition || oldDelegate.zoomLevel != zoomLevel; // Add this line
  }
}

// Main application widget
class ConicSectionApp extends StatelessWidget {
  const ConicSectionApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity), home: const ConicSectionVisualization());
  }
}

void main() {
  runApp(const ConicSectionApp());
}
