import 'package:flutter/material.dart';
import 'dart:math';

class ConicSectionsQuiz extends StatefulWidget {
  @override
  _ConicSectionsQuizState createState() => _ConicSectionsQuizState();
}

class _ConicSectionsQuizState extends State<ConicSectionsQuiz> {
  late List<Map<String, dynamic>> _quizQuestions;
  int _currentQuestionIndex = 0;
  int? _selectedOptionIndex;
  bool _isAnswered = false;
  int _score = 0;
  List<Map<String, dynamic>> _userAnswers = [];

  @override
  void initState() {
    super.initState();
    _resetQuiz();
  }

  void _resetQuiz() {
    final allQuestions = _getAllQuestions();
    final circleQs = _selectRandomQuestions(allQuestions['Circle']!, 5);
    final ellipseQs = _selectRandomQuestions(allQuestions['Ellipse']!, 5);
    final parabolaQs = _selectRandomQuestions(allQuestions['Parabola']!, 5);
    final hyperbolaQs = _selectRandomQuestions(allQuestions['Hyperbola']!, 5);

    _quizQuestions = [...circleQs, ...ellipseQs, ...parabolaQs, ...hyperbolaQs]..shuffle();

    _userAnswers = _quizQuestions.map((q) => {'question': q['question'], 'selected': null, 'correctIndex': q['correctIndex'], 'solution': q['solution'], 'isCorrect': false, 'shape': q['shape'], 'image': q['image']}).toList();

    setState(() {
      _currentQuestionIndex = 0;
      _selectedOptionIndex = null;
      _isAnswered = false;
      _score = 0;
    });
  }

  List<Map<String, dynamic>> _selectRandomQuestions(List<Map<String, dynamic>> questions, int count) {
    final shuffled = List.of(questions)..shuffle();
    return shuffled.take(count).toList();
  }

  Widget _buildQuestionImage(String? imagePath) {
    if (imagePath == null) return SizedBox.shrink();
    return Container(margin: EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)), child: Image.asset(imagePath, width: 200, height: 120, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))));
  }

  Map<String, List<Map<String, dynamic>>> _getAllQuestions() {
    return {
      'Circle': [
        {
          'shape': 'Circle',
          'question': '1. Which defines a circle?',
          'options': ['A shape with three sides', 'A set of points equidistant from a center', 'A four-sided figure', 'A polygon with equal sides'],
          'correctIndex': 1,
          'solution': 'A circle is defined as all points equidistant from a center point.',
          'image': 'assets/circle_definition.png',
        },
        {
          'shape': 'Circle',
          'question': '2. What is the fixed point in a circle called?',
          'options': ['Center', 'Chord', 'Diameter', 'Radius'],
          'correctIndex': 0,
          'solution': 'The fixed point is called the center.',
          'image': 'assets/circle_parts.png',
        },
        {
          'shape': 'Circle',
          'question': '3. The distance from center to any point on circle is:',
          'options': ['Center', 'Circumference', 'Diameter', 'Radius'],
          'correctIndex': 3,
          'solution': 'This distance is called the radius.',
          'image': 'assets/circle_radius.png',
        },
        {
          'shape': 'Circle',
          'question': '4. What is the area of a circle with radius 8cm?',
          'options': ['25.12 cm²', '100.25 cm²', '200.96 cm²', '300.50 cm²'],
          'correctIndex': 2,
          'solution': 'A = πr² = 3.14 × 8² = 200.96 cm²',
          'image': 'assets/circle_area.png',
        },
        {
          'shape': 'Circle',
          'question': '5. The general equation x² + y² - 6x + 8y - 11 = 0 has radius:',
          'options': ['2', '4', '6', '8'],
          'correctIndex': 2,
          'solution': 'Complete squares: (x-3)² + (y+4)² = 36 → r = 6',
          'image': 'assets/circle_equation.png',
        },
        {
          'shape': 'Circle',
          'question': '6. If a plane cuts a cone parallel to the base, what shape is formed?',
          'options': ['Circle', 'Ellipse', 'Hyperbola', 'Parabola'],
          'correctIndex': 0,
          'solution': 'A parallel cut forms a circle',
          'image': 'assets/cone_circle.png',
        },
        {
          'shape': 'Circle',
          'question': '7. What is the circumference of a circle with diameter 10 units?',
          'options': ['10π', '20π', '25π', '5π'],
          'correctIndex': 0,
          'solution': 'C = πd = 10π',
          'image': 'assets/circle_circumference.png',
        },
        {
          'shape': 'Circle',
          'question': '8. The standard equation of a circle centered at (3,-2) with radius 5 is:',
          'options': ['(x-3)² + (y+2)² = 5', '(x+3)² + (y-2)² = 25', '(x-3)² + (y+2)² = 25', '(x+3)² + (y-2)² = 5'],
          'correctIndex': 2,
          'solution': 'Standard form is (x-h)² + (y-k)² = r²',
          'image': 'assets/circle_standard_form.png',
        },
        {
          'shape': 'Circle',
          'question': '9. A circle has diameter endpoints at (-2,3) and (4,-5). Its center is at:',
          'options': ['(1,-1)', '(3,-4)', '(-1,1)', '(2,-2)'],
          'correctIndex': 0,
          'solution': 'Center is midpoint: ((-2+4)/2, (3-5)/2) = (1,-1)',
          'image': 'assets/circle_midpoint.png',
        },
        {
          'shape': 'Circle',
          'question': '10. The line segment from center to any point on circle is called:',
          'options': ['Chord', 'Diameter', 'Radius', 'Secant'],
          'correctIndex': 2,
          'solution': 'This is the definition of radius',
          'image': 'assets/circle_segments.png',
        },
      ],
      'Ellipse': [
        {
          'shape': 'Ellipse',
          'question': '1. In an ellipse, the longest axis is called:',
          'options': ['Eccentricity', 'Minor axis', 'Major axis', 'Conjugate axis'],
          'correctIndex': 2,
          'solution': 'The longest axis is the major axis.',
          'image': 'assets/ellipse_axes.png',
        },
        {
          'shape': 'Ellipse',
          'question': '2. An ellipse has ___ vertices and ___ foci.',
          'options': ['Two, two', 'One, two', 'Two, one', 'One, one'],
          'correctIndex': 0,
          'solution': 'Ellipses have two vertices and two foci.',
          'image': 'assets/ellipse_parts.png',
        },
        {
          'shape': 'Ellipse',
          'question': '3. The two fixed points in an ellipse are called:',
          'options': ['Co-vertices', 'Vertices', 'Foci', 'Latus Rectum'],
          'correctIndex': 2,
          'solution': 'The fixed points are called foci.',
          'image': 'assets/ellipse_foci.png',
        },
        {
          'shape': 'Ellipse',
          'question': '4. For ellipse x²/25 + y²/16 = 1, the foci are at:',
          'options': ['(0, ±3)', '(±3, 0)', '(0, ±5)', '(±5, 0)'],
          'correctIndex': 1,
          'solution': 'c² = a² - b² = 25-16 = 9 → c = 3',
          'image': 'assets/ellipse_horizontal.png',
        },
        {
          'shape': 'Ellipse',
          'question': '5. The sum of distances from any point to the two foci is:',
          'options': ['Equal to minor axis', 'Equal to major axis', 'Twice the major axis', 'Equal to latus rectum'],
          'correctIndex': 1,
          'solution': 'Constant sum equals the major axis length (2a)',
          'image': 'assets/ellipse_definition.png',
        },
        {
          'shape': 'Ellipse',
          'question': '6. The endpoints of the minor axis are called:',
          'options': ['Foci', 'Vertices', 'Co-vertices', 'Center'],
          'correctIndex': 2,
          'solution': 'These are called co-vertices',
          'image': 'assets/ellipse_covertices.png',
        },
        {
          'shape': 'Ellipse',
          'question': '7. For ellipse x²/9 + y²/36 = 1, the length of major axis is:',
          'options': ['6', '12', '18', '24'],
          'correctIndex': 1,
          'solution': '2a = 2×6 = 12',
          'image': 'assets/ellipse_vertical.png',
        },
        {
          'shape': 'Ellipse',
          'question': '8. The eccentricity of an ellipse measures:',
          'options': ['How circular it is', 'Its area', 'Distance between foci', 'Length of minor axis'],
          'correctIndex': 0,
          'solution': 'Eccentricity measures deviation from circular shape',
          'image': 'assets/ellipse_eccentricity.png',
        },
        {
          'shape': 'Ellipse',
          'question': '9. If a=5 and c=3 for an ellipse, its eccentricity is:',
          'options': ['0.6', '1.67', '0.8', '0.4'],
          'correctIndex': 0,
          'solution': 'e = c/a = 3/5 = 0.6',
          'image': 'assets/ellipse_calculation.png',
        },
        {
          'shape': 'Ellipse',
          'question': '10. The standard form of vertical ellipse centered at (2,-3) is:',
          'options': ['(x-2)²/a² + (y+3)²/b² = 1', '(x+2)²/a² + (y-3)²/b² = 1', '(y+3)²/a² + (x-2)²/b² = 1', '(y-3)²/a² + (x+2)²/b² = 1'],
          'correctIndex': 2,
          'solution': 'Vertical ellipse has y-term first with a² under it',
          'image': 'assets/ellipse_standard_form.png',
        },
      ],
      'Parabola': [
        {
          'shape': 'Parabola',
          'question': '1. The standard form of vertical parabola with vertex at origin is:',
          'options': ['(x-h)² = 4p(y-k)', 'y² = 4px', 'x² = 4py', '(y-k)² = 4p(x-h)'],
          'correctIndex': 2,
          'solution': 'x² = 4py is the standard form.',
          'image': 'assets/parabola_vertical.png',
        },
        {
          'shape': 'Parabola',
          'question': '2. The vertex of parabola (y-2)² = 8(x-3) is at:',
          'options': ['(3, 2)', '(2, 3)', '(-3, -2)', '(8, 3)'],
          'correctIndex': 0,
          'solution': 'Vertex is at (h,k) = (3,2)',
          'image': 'assets/parabola_vertex.png',
        },
        {
          'shape': 'Parabola',
          'question': '3. The parabola x² = -12y opens:',
          'options': ['Upward', 'Downward', 'Left', 'Right'],
          'correctIndex': 1,
          'solution': 'Negative coefficient means it opens downward',
          'image': 'assets/parabola_direction.png',
        },
        {
          'shape': 'Parabola',
          'question': '4. The focus of parabola (x+1)² = 8(y-3) is at:',
          'options': ['(-1, 5)', '(1, 5)', '(-1, 1)', '(1, 1)'],
          'correctIndex': 0,
          'solution': '4p=8 → p=2. Focus at (h,k+p) = (-1,3+2) = (-1,5)',
          'image': 'assets/parabola_focus.png',
        },
        {
          'shape': 'Parabola',
          'question': '5. The directrix of parabola y² = 16x is:',
          'options': ['x = 4', 'x = -4', 'y = 4', 'y = -4'],
          'correctIndex': 1,
          'solution': '4p=16 → p=4. Directrix is x = -p = -4',
          'image': 'assets/parabola_directrix.png',
        },
        {
          'shape': 'Parabola',
          'question': '6. The latus rectum of parabola (x-2)² = -12(y+1) has length:',
          'options': ['12', '6', '24', '3'],
          'correctIndex': 0,
          'solution': '|4p|=12 → length is 12 units',
          'image': 'assets/parabola_latus.png',
        },
        {
          'shape': 'Parabola',
          'question': '7. A satellite dish has parabolic shape. This is because:',
          'options': ['It s aesthetically pleasing', 'It reflects signals to focus', 'It s structurally strong', 'It minimizes material usage'],
          'correctIndex': 1,
          'solution': 'Parabolic shape reflects incoming signals to the focus',
          'image': 'assets/parabola_satellite.png',
        },
        {
          'shape': 'Parabola',
          'question': '8. The axis of symmetry for parabola (y-4)² = 16(x+2) is:',
          'options': ['x = -2', 'y = 4', 'x = 2', 'y = -4'],
          'correctIndex': 1,
          'solution': 'Horizontal parabola has vertical axis y=k',
          'image': 'assets/parabola_axis.png',
        },
        {
          'shape': 'Parabola',
          'question': '9. The path of a thrown ball approximates a:',
          'options': ['Circle', 'Ellipse', 'Parabola', 'Hyperbola'],
          'correctIndex': 2,
          'solution': 'Projectile motion follows parabolic path',
          'image': 'assets/parabola_projectile.png',
        },
        {
          'shape': 'Parabola',
          'question': '10. For the parabola shown, what is its equation?',
          'options': ['y² = 12x', 'x² = 12y', 'y = 12x²', 'x = 12y²'],
          'correctIndex': 1,
          'solution': 'The parabola opens upward with vertex at origin',
          'image': 'assets/parabola_graph.png',
        },
      ],
      'Hyperbola': [
        {
          'shape': 'Hyperbola',
          'question': '1. What are the asymptotes of hyperbola x²/25 - y²/81 = 1?',
          'options': ['y = ± (5/9)x', 'y = ± (9/5)x', 'y = ± (4/9)x', 'y = ± (9/4)x'],
          'correctIndex': 1,
          'solution': 'a=5, b=9 → asymptotes y = ±(b/a)x = ±(9/5)x',
          'image': 'assets/hyperbola_asymptotes.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '2. Give the coordinates of foci in hyperbola (y-9)²/10 - (x-6)²/6 = 1',
          'options': ['F(6, 13), (6, 5)', 'F(-6, 10), (6, -10)', 'F(9, 10), (9, 13)', 'F(6, -13), (9, -5)'],
          'correctIndex': 0,
          'solution': 'Vertical hyperbola, c²=10+6=16 → c=4 → foci at (6,9±4)',
          'image': 'assets/hyperbola_foci.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '3. What is the length of transverse axis of x²/4 - y²/16 = 1?',
          'options': ['2', '4', '8', '6'],
          'correctIndex': 1,
          'solution': 'a²=4 → a=2 → transverse axis length = 2a = 4',
          'image': 'assets/hyperbola_transverse.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '4. Convert 4x² - 9y² - 16x + 54y = 137 to standard form',
          'options': ['(x-2)²/15 - (y-7)²/9 = 1', '(x-2)²/18 - (y-3)²/8 = 1', '(x-4)²/6 - (y-9)²/18 = 1', '(x-4)²/18 - (y-8)²/15 = 1'],
          'correctIndex': 1,
          'solution': 'Complete squares: 4(x-2)² - 9(y-3)² = 72 → (x-2)²/18 - (y-3)²/8 = 1',
          'image': 'assets/hyperbola_completing_square.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '5. Find c of y² - 25x² = 25',
          'options': ['c = 5', 'c = √32', 'c = √26', 'c = 15'],
          'correctIndex': 2,
          'solution': 'Divide by 25: y²/25 - x²/1 = 1 → c²=25+1=26 → c=√26',
          'image': 'assets/hyperbola_calculation.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '6. Length of conjugate axis for y²/225 - x²/100 = 1?',
          'options': ['25', '20', '50', '10'],
          'correctIndex': 1,
          'solution': 'b²=100 → b=10 → conjugate axis length = 2b = 20',
          'image': 'assets/hyperbola_conjugate.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '7. Standard form with vertices at (0,±9) passing through (8,15)',
          'options': ['y²/78 - x²/40 = 1', 'y²/81 - x²/36 = 1', 'y²/67 - x²/36 = 1', 'y²/90 - x²/40 = 1'],
          'correctIndex': 1,
          'solution': 'a=9 → a²=81 → 225/81 - 64/b²=1 → b²=36 → y²/81 - x²/36 = 1',
          'image': 'assets/hyperbola_standard_form.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '8. Tower 198m tall, equation x²/36 - y²/484 = 1. Width at narrowest part?',
          'options': ['15 meters', '12 meters', '4 meters', '17 meters'],
          'correctIndex': 1,
          'solution': 'a²=36 → a=6 → width at narrowest = 2a = 12 meters',
          'image': 'assets/hyperbola_tower.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '9. Cooling tower has hyperbolic cross-section. What is its narrowest width?',
          'options': ['6 meters', '8 meters', '10 meters', '12 meters'],
          'correctIndex': 0,
          'solution': 'From equation x²/9 - y²/121 = 1 → a=3 → width=6m',
          'image': 'assets/hyperbola_cooling_tower.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '10. The graph shown represents which hyperbola equation?',
          'options': ['x²/16 - y²/9 = 1', 'y²/9 - x²/16 = 1', 'x²/9 - y²/16 = 1', 'y²/16 - x²/9 = 1'],
          'correctIndex': 0,
          'solution': 'The hyperbola opens horizontally with a=4, b=3',
          'image': 'assets/hyperbola_graph.png',
        },
      ],
    };
  }

  void _answerQuestion(int optionIndex) {
    if (!_isAnswered) {
      setState(() {
        _selectedOptionIndex = optionIndex;
        _isAnswered = true;
        _userAnswers[_currentQuestionIndex] = {..._userAnswers[_currentQuestionIndex], 'selected': optionIndex, 'isCorrect': optionIndex == _quizQuestions[_currentQuestionIndex]['correctIndex']};
        if (optionIndex == _quizQuestions[_currentQuestionIndex]['correctIndex']) {
          _score++;
        }
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOptionIndex = null;
        _isAnswered = false;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsScreen(score: _score, totalQuestions: _quizQuestions.length, userAnswers: _userAnswers, quizQuestions: _quizQuestions, onRestart: _resetQuiz)));
    }
  }

  Color _getOptionColor(int optionIndex) {
    if (!_isAnswered) return Colors.white;
    if (optionIndex == _quizQuestions[_currentQuestionIndex]['correctIndex']) {
      return Colors.green.shade100;
    } else if (optionIndex == _selectedOptionIndex) {
      return Colors.red.shade100;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (_quizQuestions.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = _quizQuestions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Conic Sections Quiz (${_currentQuestionIndex + 1}/${_quizQuestions.length})'), backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, actions: [Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Score: $_score/${_quizQuestions.length}', style: TextStyle(color: Colors.white))))]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(elevation: 4, child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [Text(currentQuestion['shape'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple)), SizedBox(height: 8), Text(currentQuestion['question'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))]))),

              _buildQuestionImage(currentQuestion['image']),

              SizedBox(height: 20),

              ...List.generate(currentQuestion['options'].length, (index) {
                return Card(
                  elevation: 2,
                  color: _getOptionColor(index),
                  child: ListTile(
                    title: Text(currentQuestion['options'][index]),
                    onTap: () => _answerQuestion(index),
                    leading: Icon(
                      _isAnswered && index == _selectedOptionIndex
                          ? (_selectedOptionIndex == currentQuestion['correctIndex'] ? Icons.check_circle : Icons.cancel)
                          : _isAnswered && index == currentQuestion['correctIndex']
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color:
                          _isAnswered && index == currentQuestion['correctIndex']
                              ? Colors.green
                              : _isAnswered && index == _selectedOptionIndex
                              ? Colors.red
                              : Colors.grey,
                    ),
                  ),
                );
              }),

              SizedBox(height: 20),

              if (_isAnswered) Card(color: _selectedOptionIndex == currentQuestion['correctIndex'] ? Colors.green.shade50 : Colors.red.shade50, child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [Text(_selectedOptionIndex == currentQuestion['correctIndex'] ? '✓ Correct!' : '✗ Incorrect!', style: TextStyle(fontWeight: FontWeight.bold, color: _selectedOptionIndex == currentQuestion['correctIndex'] ? Colors.green : Colors.red, fontSize: 20)), SizedBox(height: 10), Text(currentQuestion['solution'])]))),

              SizedBox(height: 20),

              ElevatedButton(onPressed: _isAnswered ? _nextQuestion : null, style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)), child: Text(_currentQuestionIndex < _quizQuestions.length - 1 ? 'Next Question' : 'Finish Quiz', style: TextStyle(fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> userAnswers;
  final List<Map<String, dynamic>> quizQuestions;
  final VoidCallback onRestart;
  const ResultsScreen({Key? key, required this.score, required this.totalQuestions, required this.userAnswers, required this.quizQuestions, required this.onRestart}) : super(key: key);

  String _getGrade() {
    double percentage = (score / totalQuestions) * 100;
    if (percentage >= 90) return 'A';
    if (percentage >= 80) return 'B';
    if (percentage >= 70) return 'C';
    if (percentage >= 60) return 'D';
    return 'F';
  }

  Color _getGradeColor() {
    double percentage = (score / totalQuestions) * 100;
    if (percentage >= 90) return Colors.green;
    if (percentage >= 80) return Colors.blue;
    if (percentage >= 70) return Colors.orange;
    if (percentage >= 60) return Colors.yellow.shade700;
    return Colors.red;
  }

  Widget _buildQuestionImage(String? imagePath) {
    if (imagePath == null) return SizedBox.shrink();
    return Container(margin: EdgeInsets.symmetric(vertical: 5), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)), child: Image.asset(imagePath, width: 150, height: 80, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              Navigator.pop(context);
              onRestart();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              color: Colors.deepPurple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(Icons.emoji_events, size: 60, color: Colors.deepPurple),
                    SizedBox(height: 10),
                    Text('Your Score', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('$score out of $totalQuestions', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Container(width: double.infinity, height: 20, decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300), child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: score / totalQuestions, child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: _getGradeColor())))),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(children: [Text('${((score / totalQuestions) * 100).toStringAsFixed(1)}%', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)), Text('Percentage', style: TextStyle(color: Colors.grey))]),
                        Column(children: [Text(_getGrade(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _getGradeColor())), Text('Grade', style: TextStyle(color: Colors.grey))]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: totalQuestions,
                itemBuilder: (context, index) {
                  final answer = userAnswers[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 3,
                    color: answer['isCorrect'] ? Colors.green.shade50 : Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [Icon(answer['isCorrect'] ? Icons.check_circle : Icons.cancel, color: answer['isCorrect'] ? Colors.green : Colors.red, size: 20), SizedBox(width: 8), Expanded(child: Text('${answer['shape']} - Question ${index + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: answer['isCorrect'] ? Colors.green.shade900 : Colors.red.shade900, fontSize: 16)))]),
                          SizedBox(height: 8),
                          Text(answer['question']),
                          SizedBox(height: 8),
                          if (answer['image'] != null) _buildQuestionImage(answer['image']),
                          SizedBox(height: 8.0),
                          Text('Your answer: ${answer['selected'] != null ? quizQuestions[index]['options'][answer['selected']] : 'Not answered'}', style: TextStyle(color: answer['isCorrect'] ? Colors.green.shade900 : Colors.red.shade900, fontWeight: FontWeight.w500)),
                          Text('Correct answer: ${quizQuestions[index]['options'][answer['correctIndex']]}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900)),
                          SizedBox(height: 8),
                          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.deepPurple.shade50, borderRadius: BorderRadius.circular(4)), child: Text('Solution: ${answer['solution']}', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13, color: Colors.deepPurple.shade800))),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                onRestart();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.refresh), SizedBox(width: 8), Text('Restart Quiz', style: TextStyle(fontSize: 18))]),
            ),
          ],
        ),
      ),
    );
  }
}
