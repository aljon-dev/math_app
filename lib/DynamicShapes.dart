import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:math_app/Circle/CircleExample.dart';
import 'package:math_app/Circle/CirclePart.dart';
import 'package:math_app/Circle/CircleQuiz.dart';
import 'package:math_app/Circle/DefinitionCircle.dart';
import 'package:math_app/Circle/FormulaCircle.dart';
import 'package:math_app/Ellipse/DefinitionEllipse.dart';
import 'package:math_app/Ellipse/EllipseExamples.dart';
import 'package:math_app/Ellipse/EllipseFormula.dart';
import 'package:math_app/Ellipse/EllipsePart.dart';
import 'package:math_app/Ellipse/EllipseQuiz.dart';
import 'package:math_app/Hyperbola/HyperbolaDefinition.dart';
import 'package:math_app/Hyperbola/HyperbolaExample.dart';
import 'package:math_app/Hyperbola/HyperbolaFormula.dart';
import 'package:math_app/Hyperbola/HyperbolaPart.dart';
import 'package:math_app/Hyperbola/HyperbolaQuiz.dart';
import 'package:math_app/Menu.dart';
import 'package:math_app/Parabola/ParabolaDefinition.dart';
import 'package:math_app/Parabola/ParabolaExample.dart';
import 'package:math_app/Parabola/ParabolaFormula.dart';
import 'package:math_app/Parabola/ParabolaPart.dart';
import 'package:math_app/Parabola/ParabolaQuiz.dart';
import 'package:vector_math/vector_math.dart' as vector_math;

class DynamicShapes extends StatefulWidget {
  final double planeAngle;
  final double horizontalRotation;
  final double verticalPosition;
  const DynamicShapes({Key? key, required this.planeAngle, required this.horizontalRotation, required this.verticalPosition}) : super(key: key);

  @override
  State<DynamicShapes> createState() => _ConicSectionVisualizationState();
}

class _ConicSectionVisualizationState extends State<DynamicShapes> with TickerProviderStateMixin {
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

  Future<void> Menu() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return SizedBox(
          height: 300, // <-- control height here
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonMenu(
                        _currentType == 'Circle'
                            ? Colors.red
                            : _currentType == 'Ellipse'
                            ? Colors.orange
                            : _currentType == 'Parabola'
                            ? Colors.green
                            : _currentType == 'Hyperbola'
                            ? Colors.blue
                            : Colors.red,
                        'Definition',
                        _currentType,
                      ),
                      ButtonMenu(
                        _currentType == 'Circle'
                            ? Colors.red
                            : _currentType == 'Ellipse'
                            ? Colors.orange
                            : _currentType == 'Parabola'
                            ? Colors.green
                            : _currentType == 'Hyperbola'
                            ? Colors.blue
                            : Colors.red,
                        'Parts',
                        _currentType,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonMenu(
                        _currentType == 'Circle'
                            ? Colors.red
                            : _currentType == 'Ellipse'
                            ? Colors.orange
                            : _currentType == 'Parabola'
                            ? Colors.green
                            : _currentType == 'Hyperbola'
                            ? Colors.blue
                            : Colors.red,
                        'Formulas',
                        _currentType,
                      ),
                      ButtonMenu(
                        _currentType == 'Circle'
                            ? Colors.red
                            : _currentType == 'Ellipse'
                            ? Colors.orange
                            : _currentType == 'Parabola'
                            ? Colors.green
                            : _currentType == 'Hyperbola'
                            ? Colors.blue
                            : Colors.red,
                        'Examples',
                        _currentType,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ButtonMenu(
                      _currentType == 'Circle'
                          ? Colors.red
                          : _currentType == 'Ellipse'
                          ? Colors.orange
                          : _currentType == 'Parabola'
                          ? Colors.green
                          : _currentType == 'Hyperbol'
                          ? Colors.blue
                          : Colors.red,
                      'Quiz',
                      _currentType,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // Set the values from the parent
    _planeAngle = widget.planeAngle;
    _horizontalRotation = widget.horizontalRotation;
    _verticalPosition = widget.verticalPosition;

    // Update conic type after values are set
    _updateConicType();

    // Start animation controller
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 10))..addListener(() {
      setState(() {
        _horizontalRotation = _animationController.value * 2 * math.pi;
      });
    });

    // Show menu once everything is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Menu();
    });
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
    } else if (_planeAngle < 0.7) {
      _currentType = "Ellipse";
    } else if (_planeAngle < 1.2) {
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
          Expanded(
            flex: 3,
            child: GestureDetector(
              onPanStart: (details) {
                _lastPanX = details.localPosition.dx;
                _lastPanY = details.localPosition.dy;
              },
              onPanUpdate: (details) {
                setState(() {
                  // Calculate the delta
                  final dx = details.localPosition.dx - _lastPanX;
                  final dy = details.localPosition.dy - _lastPanY;

                  // Update rotations
                  _horizontalRotation += dx * 0.01;
                  _planeAngle = (_planeAngle - dy * 0.01).clamp(0, math.pi / 2);

                  _lastPanX = details.localPosition.dx;
                  _lastPanY = details.localPosition.dy;

                  _updateConicType();
                });
              },
              child: CustomPaint(painter: ConicSectionPainter(planeAngle: _planeAngle, horizontalRotation: _horizontalRotation, verticalPosition: _verticalPosition), child: Container()),
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

  Widget ButtonMenu(Color color, String menuTitle, String Shape) {
    return SizedBox(
      height: 80,
      width: 150,
      child: ElevatedButton(
        onPressed: () {
          if (Shape == 'Circle') {
            switch (menuTitle) {
              case 'Definition':
                Navigator.push(context, MaterialPageRoute(builder: (context) => DefinitionSection()));

                break;
              case 'Formulas':
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormulasSection()));
                break;
              case 'Parts':
                Navigator.push(context, MaterialPageRoute(builder: (context) => CirclePartsScreen()));
                break;
              case 'Examples':
                Navigator.push(context, MaterialPageRoute(builder: (context) => CircleExamplesApp()));
                break;
              case 'Quiz':
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen()));

              default:
                break;
            }
          }

          if (Shape == 'Ellipse') {
            switch (menuTitle) {
              case 'Definition':
                Navigator.push(context, MaterialPageRoute(builder: (context) => DefinitionSectionEllipse()));
                break;
              case 'Formulas':
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormulasEllipseSection()));
                break;
              case 'Parts':
                Navigator.push(context, MaterialPageRoute(builder: (context) => EllipsePartsScreen()));
                break;
              case 'Examples':
                Navigator.push(context, MaterialPageRoute(builder: (context) => EllipseExamplesApp()));
                break;

              case 'Quiz':
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreenEllipse()));

              default:
                break;
            }
          }

          if (Shape == 'Parabola') {
            switch (menuTitle) {
              case 'Definition':
                Navigator.push(context, MaterialPageRoute(builder: (context) => ParabolaDefinitionSection()));
                break;
              case 'Formulas':
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormulasParabolaSection()));
                break;
              case 'Parts':
                Navigator.push(context, MaterialPageRoute(builder: (context) => ParabolaPartsScreen()));
                break;
              case 'Examples':
                Navigator.push(context, MaterialPageRoute(builder: (context) => ParabolaExamplesApp()));
                break;
              case 'Quiz':
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreenParabola()));

              default:
                break;
            }
          }

          if (Shape == 'Hyperbola') {
            switch (menuTitle) {
              case 'Definition':
                Navigator.push(context, MaterialPageRoute(builder: (context) => DefinitionHyperBolaSection()));
                break;
              case 'Formulas':
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormulasHyperbolaSection()));
                break;
              case 'Parts':
                Navigator.push(context, MaterialPageRoute(builder: (context) => HyperbolaPartsScreen()));
                break;
              case 'Examples':
                Navigator.push(context, MaterialPageRoute(builder: (context) => HyperbolaExamplesApp()));
                break;
              case 'Quiz':
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreenHyperBola()));

              default:
                break;
            }
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10), side: const BorderSide(color: Colors.black, width: 2))),
        child: Text(menuTitle, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}

class ConicSectionPainter extends CustomPainter {
  final double planeAngle;
  final double horizontalRotation;
  final double verticalPosition;

  // Constants
  final double _coneHeight = 2.0;
  final double _coneRadius = 1.0;

  ConicSectionPainter({required this.planeAngle, required this.horizontalRotation, required this.verticalPosition});

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final scale = math.min(size.width, size.height) * 0.3;

    // Create a 3D scene
    final scene = _createScene(scale);

    // Project 3D vertices to 2D
    final projectedVertices = _projectVertices(scene, centerX, centerY, scale);

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
    final planeWidth = _coneRadius * 2.5;
    final planeVertices2D = [vector_math.Vector3(-planeWidth, 0, -planeWidth), vector_math.Vector3(planeWidth, 0, -planeWidth), vector_math.Vector3(planeWidth, 0, planeWidth), vector_math.Vector3(-planeWidth, 0, planeWidth)];

    // Apply the SAME transformation in both plane drawing and intersection calculation
    final rotationMatrix = vector_math.Matrix4.rotationX(planeAngle);
    rotationMatrix.translate(0.0, verticalPosition * _coneHeight, 0.0);

    for (final vertex in planeVertices2D) {
      vertices.add(rotationMatrix.transformed3(vertex));
    }

    return vertices;
  }

  List<Offset> _projectVertices(List<vector_math.Vector3> vertices, double centerX, double centerY, double scale) {
    // Camera settings
    final cameraPosition = vector_math.Vector3(0, 0, 5);
    final cameraLookAt = vector_math.Vector3(0, 0, 0);
    final cameraUp = vector_math.Vector3(0, 1, 0);

    // Compute view matrix
    final viewMatrix = vector_math.makeViewMatrix(cameraPosition, cameraLookAt, cameraUp);

    // Compute projection matrix (perspective)
    final projectionMatrix = vector_math.makePerspectiveMatrix(
      45 * math.pi / 180, // FOV
      1.0, // Aspect ratio
      0.1, // Near plane
      100.0, // Far plane
    );

    // Compute model matrix (rotate the scene)
    final modelMatrix = vector_math.Matrix4.rotationY(horizontalRotation);

    // Compute MVP matrix
    final mvpMatrix = projectionMatrix * viewMatrix * modelMatrix;

    // Project 3D vertices to 2D screen space
    return vertices.map((v) {
      // Apply MVP transformation
      final projected = mvpMatrix.transformed3(v);

      // Perspective division
      final x = projected.x / projected.z;
      final y = projected.y / projected.z;

      // Map to screen coordinates
      return Offset(
        centerX + x * scale,
        centerY - y * scale, // Flip Y for screen coordinates
      );
    }).toList();
  }

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

    // Draw semi-transparent surface fill for better 3D look
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
    for (int i = 39; i <= 74; i++) {
      path.lineTo(projectedVertices[i].dx, projectedVertices[i].dy);
    }
    path.close();

    // Draw shadow for 3D effect
    canvas.drawPath(path, shadowPaint);
    canvas.drawPath(path, lowerBasePaint);

    // Draw semi-transparent surface fill for better 3D look
    final fillPaint =
        Paint()
          ..shader = RadialGradient(colors: [Colors.blue.withOpacity(0.8), Colors.teal.withOpacity(0.6)], stops: [0.0, 1.0]).createShader(Rect.fromCircle(center: apex, radius: 200))
          ..style = PaintingStyle.fill;

    // Create triangular faces for the cone surface
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
    // Draw the plane
    final planePaint =
        Paint()
          ..color = Colors.lightBlue.withOpacity(0.3)
          ..style = PaintingStyle.fill;

    final planeOutlinePaint =
        Paint()
          ..color = const Color.fromARGB(255, 213, 9, 37)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;

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

    // Draw the conic section with dynamic color
    final conicPaint =
        Paint()
          ..color = _getConicColor(currentType)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0;

    // For hyperbola case, we need to draw both branches
    if (planeAngle > 0.9) {
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
        if (planeAngle < 0.7) path.close(); // Close for circles/ellipses
        canvas.drawPath(path, conicPaint);
      }
    }
  }

  // NEW: Determine current conic type based on plane angle
  String _getCurrentConicType() {
    if (planeAngle < 0.1) {
      return 'Circle';
    } else if (planeAngle < 0.7) {
      return 'Ellipse';
    } else if (planeAngle < 1.2) {
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
    final planeWidth = _coneRadius * 2.5;
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
    return oldDelegate.planeAngle != planeAngle || oldDelegate.horizontalRotation != horizontalRotation || oldDelegate.verticalPosition != verticalPosition;
  }
}
