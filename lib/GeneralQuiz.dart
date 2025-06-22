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
    if (imagePath == null || imagePath.isEmpty) return SizedBox.shrink();
    return Container(margin: EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)), child: Image.asset(imagePath, width: 200, height: 120, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not available', style: TextStyle(color: Colors.grey)))));
  }

  Map<String, List<Map<String, dynamic>>> _getAllQuestions() {
    return {
      'Circle': [
        {
          'shape': 'Circle',
          'question': 'Which of the following defines a circle?',
          'options': ['A shape with three sides', 'A set of points equidistant from a center', 'A four-sided figure', 'A polygon with equal sides'],
          'correctIndex': 1,
          'solution': 'Answer: b) A set of points equidistant from a center',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' What is the fixed point in a circle called?',
          'options': ['Center', 'Chord', 'Diameter', 'Radius'],
          'correctIndex': 0,
          'solution': 'Answer: a) Center',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' The distance from the center of a circle to any point on the circle is called:',
          'options': ['Center', 'Circumference', 'Diameter', 'Radius'],
          'correctIndex': 3,
          'solution': 'Answer: d) Radius',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' If a plane cuts a cone parallel to the base, what shape is formed?',
          'options': ['Circle', 'Ellipse', 'Hyperbola', 'Parabola'],
          'correctIndex': 0,
          'solution': 'Answer: a) Circle',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' What is the area if the circle has a radius of 8 cm?',
          'options': ['25.12 cm²', '100.25 cm²', '200.96 cm²', '300.50 cm²'],
          'correctIndex': 2,
          'solution': 'SOLUTION: A = πr² = 3.14 × 8² = 200.96 cm²',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' If the general equation of the circle is x² + y² - 6x + 8y - 11 = 0, what is the radius?',
          'options': ['2', '4', '6', '8'],
          'correctIndex': 2,
          'solution': 'SOLUTION: Complete squares: (x-3)² + (y+4)² = 36 → r = 6',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' What is the general form of (x+5)² + (y-2)² = 2²?',
          'options': ['x² + y² - 10x + 4y + 25 = 0', 'x² + y² - 10x - 4y - 25 = 0', 'x² - y² - 10x + 4y + 25 = 0', 'x² + y² + 10x - 4y + 25 = 0'],
          'correctIndex': 3,
          'solution': 'SOLUTION: Expand and simplify to get x² + y² + 10x - 4y + 25 = 0',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' A satellite orbits the earth with points at (-4,6) and (8,-2). What is the center?',
          'options': ['(-2,2)', '(2,2)', '(4,4)', '(-4,4)'],
          'correctIndex': 1,
          'solution': 'SOLUTION: Midpoint formula gives (2,2)',
          'image': 'assets/satellite_orbit.png',
        },
        {
          'shape': 'Circle',
          'question': ' What is the circumference of a circle with diameter 10 units?',
          'options': ['10π', '20π', '25π', '5π'],
          'correctIndex': 0,
          'solution': 'SOLUTION: C = πd = 10π',
          'image': '',
        },
        {
          'shape': 'Circle',
          'question': ' The line segment from center to any point on circle is called:',
          'options': ['Chord', 'Diameter', 'Radius', 'Secant'],
          'correctIndex': 2,
          'solution': 'Answer: c) Radius',
          'image': '',
        },
      ],
      'Ellipse': [
        {
          'shape': 'Ellipse',
          'question': ' In an ellipse, the longest axis is called:',
          'options': ['Eccentricity', 'Minor axis', 'Major axis', 'Conjugate axis'],
          'correctIndex': 2,
          'solution': 'Answer: c) Major axis',
          'image': '',
        },
        {
          'shape': 'Ellipse',
          'question': ' An ellipse has ___ vertices and ___ foci.',
          'options': ['Two, two', 'One, two', 'Two, one', 'One, one'],
          'correctIndex': 0,
          'solution': 'Answer: a) Two, two',
          'image': '',
        },
        {
          'shape': 'Ellipse',
          'question': ' The two fixed points in the ellipse are called ___.',
          'options': ['Co-vertices', 'Vertices', 'Foci', 'Latus Rectum'],
          'correctIndex': 2,
          'solution': 'Answer: c) Foci',
          'image': '',
        },
        {
          'shape': 'Ellipse',
          'question': ' The endpoints of the minor axis of an ellipse are called:',
          'options': ['Foci', 'Vertices', 'Co-vertices', 'Center'],
          'correctIndex': 2,
          'solution': 'Answer: c) Co-vertices',
          'image': '',
        },
        {
          'shape': 'Ellipse',
          'question': ' What are the coordinates of the foci for an ellipse with a horizontal major axis centered at (0,0)?',
          'options': ['(0, ±c)', '(±c, 0)', '(h, k±c)', '(h±a, c)'],
          'correctIndex': 1,
          'solution': 'Answer: b) (±c, 0)',
          'image': '',
        },
        {
          'shape': 'Ellipse',
          'question': ' Which equation represents the ellipse shown?',
          'options': ['(x+4)²/9 + (y+6)²/81 = 1', '(x-7)²/25 + (y+5)²/16 = 1', '(x-3)²/49 + (y+2)²/9 = 1', '(x+3)²/9 + (y-5)²/36 = 1'],
          'correctIndex': 3,
          'solution': 'SOLUTION: Center at (-3,5), a=6, b=3 → (x+3)²/9 + (y-5)²/36 = 1',
          'image': 'assets/ellipse_graph.jpg',
        },
        {
          'shape': 'Ellipse',
          'question': ' An athlete follows an elliptical track. If one focus is at (-5,0), what is the other focus?',
          'options': ['(5,0)', '(0,-5)', '(-5,5)', '(5,5)'],
          'correctIndex': 0,
          'solution': 'Answer: a) (5,0)',
          'image': '',
        },
        {
          'shape': 'Ellipse',
          'question': ' A swimming pool shaped like an ellipse has major axis length 16 units. If foci are at (0,±6), what are the vertices?',
          'options': ['(±8,0)', '(0,±8)', '(±9,0)', '(0,±9)'],
          'correctIndex': 1,
          'solution': 'SOLUTION: 2a=16 → a=8 → vertices at (0,±8)',
          'image': '',
        },
        {
          'shape': 'Ellipse',
          'question': ' In a whispering gallery with foci at (-6,0) and (6,0) and major axis 20 meters, what is the equation?',
          'options': ['x²/100 + y²/144 = 1', 'x²/36 + y²/16 = 1', 'x²/100 + y²/64 = 1', 'x²/81 + y²/49 = 1'],
          'correctIndex': 2,
          'solution': 'SOLUTION: a=10, c=6 → b=8 → x²/100 + y²/64 = 1',
          'image': 'assets/whispering_gallery.png',
        },
        {
          'shape': 'Ellipse',
          'question': ' A bridge arc is shaped like half an ellipse. Highest point is 8ft, width is 28ft. What is the equation?',
          'options': ['x²/144 + y²/64 = 1', 'x²/100 + y²/169 = 1', 'x²/64 + y²/121 = 1', 'x²/196 + y²/64 = 1'],
          'correctIndex': 3,
          'solution': 'SOLUTION: a=14, b=8 → x²/196 + y²/64 = 1',
          'image': 'assets/bridge_arc.png',
        },
      ],
      'Parabola': [
        {
          'shape': 'Parabola',
          'question': ' What is the standard form equation of a vertically opening parabola with vertex at origin?',
          'options': ['(x-h)² = 4p(y-k)', 'y² = 4px', 'x² = 4py', '(y-k)² = 4p(x-h)'],
          'correctIndex': 2,
          'solution': 'Answer: c) x² = 4py',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': ' The vertex of a parabola is the point that...',
          'options': ['Is the midpoint of the focus and directrix', 'Lies at the center of the parabola', 'Is always at (0,0)', 'Lies on the directrix'],
          'correctIndex': 0,
          'solution': 'Answer: a) Is the midpoint of the focus and directrix',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': 'What is the directrix of a parabola?',
          'options': ['A point inside the parabola', 'A fixed straight line used to define the parabola', 'The longest chord of the parabola', 'A line perpendicular to the axis of symmetry'],
          'correctIndex': 1,
          'solution': 'Answer: b) A fixed straight line used to define the parabola',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': ' The equation (y-2)² = 8(x-3) represents a parabola that opens...',
          'options': ['Upward', 'Downward', 'To the left', 'To the right'],
          'correctIndex': 3,
          'solution': 'SOLUTION: p=2 > 0 → opens to the right',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': ' Find the vertex of (y-1)² = -4(x+3)',
          'options': ['(3,-1)', '(3,1)', '(-3,1)', '(-3,-1)'],
          'correctIndex': 2,
          'solution': 'SOLUTION: Vertex is at (h,k) = (-3,1)',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': ' Write the equation of a parabola with vertex at (1,-3), opens right, and latus rectum length of 8 units.',
          'options': ['(x+3)² = 8(y-1)', '(y+3)² = 8(x-1)', '(x-3)² = -8(y-1)', '(y+3)² = -8(x-1)'],
          'correctIndex': 1,
          'solution': 'SOLUTION: (y+3)² = 8(x-1)',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': ' Find the focus of x² = 36(y+8)',
          'options': ['(0,1)', '(1,0)', '(0,-1)', '(-1,0)'],
          'correctIndex': 0,
          'solution': 'SOLUTION: p=9 → focus at (0,-8+9) = (0,1)',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': 'comet`s path around the sun is roughly modeled by a hyperbola. Which of the following equations could represent this path (assuming the sun is at a focus)?',
          'options': ['a.	x² + y² = 1 ', 'b.	y = x² ', '	x^2/9  - y^2/16 = 1', '	x² + y^2/4 = 1 '],
          'correctIndex': 2,
          'solution': 'Answer: c) Parabola',
          'image': 'assets/comet_path.png',
        },
        {
          'shape': 'Parabola',
          'question': ' The latus rectum of (x-2)² = -12(y+1) has length:',
          'options': ['12', '6', '24', '3'],
          'correctIndex': 0,
          'solution': 'SOLUTION: |4p|=12 → length is 12 units',
          'image': '',
        },
        {
          'shape': 'Parabola',
          'question': ' The directrix of y² = 16x is:',
          'options': ['x=4', 'x=-4', 'y=4', 'y=-4'],
          'correctIndex': 1,
          'solution': 'SOLUTION: p=4 → directrix is x=-4',
          'image': '',
        },
      ],
      'Hyperbola': [
        {
          'shape': 'Hyperbola',
          'question': ' What is the equation of hyperbola with center at (h,k) and transverse axis parallel to y-axis?',
          'options': ['Ax² + By² + Cx + Dy + E = 0', '(y-k)²/a² - (x-h)²/b² = 1', '(x-h)²/a² - (y-k)²/b² = 1', 'Ax² - By² - Cx - Dy - E = 0'],
          'correctIndex': 1,
          'solution': 'Answer: b) (y-k)²/a² - (x-h)²/b² = 1',
          'image': '',
        },
        {
          'shape': 'Hyperbola',
          'question': 'Find the vertices of (y-8)²/9 - (x-4)²/16 = 1',
          'options': ['V(4,13), (-4,3)', 'V(-3,10), (3,3)', 'V(4,11), (4,5)', 'V(-4,-10), (-4,3)'],
          'correctIndex': 2,
          'solution': 'SOLUTION: a=3 → vertices at (4,8±3) = (4,11) and (4,5)',
          'image': '',
        },
        {
          'shape': 'Hyperbola',
          'question': ' Determine the center of 9x² - 2y² + 54x + 4y - 11 = 0',
          'options': ['(-3,1)', '(3,2)', '(-3,-2)', '(-1,3)'],
          'correctIndex': 0,
          'solution': 'SOLUTION: Complete squares → center at (-3,1)',
          'image': '',
        },
        {
          'shape': 'Hyperbola',
          'question': ' Transform (x-4)²/4 - (y-5)²/25 = 1 to general form',
          'options': ['20x² + 4y² + 200x + 50y + 50 = 0', '-25x² + 4y² + 100x + 40y + 50 = 0', '20x² - 4y² + 100x + 20y + 200 = 0', '25x² - 4y² - 200x + 40y + 200 = 0'],
          'correctIndex': 3,
          'solution': 'SOLUTION: 25x² - 4y² - 200x + 40y + 200 = 0',
          'image': '',
        },
        {
          'shape': 'Hyperbola',
          'question': ' A cooling tower modeled by x²/9 - y²/121 = 1 has width at narrowest part of:',
          'options': ['8m', '6m', '10m', '12m'],
          'correctIndex': 1,
          'solution': 'SOLUTION: a=3 → width=6 meters',
          'image': 'assets/hyperbola_powerplant.png',
        },
        {
          'shape': 'Hyperbola',
          'question': ' A hyperbola has vertices at (0,±6) and asymptotes y = ±(3/2)x. What is its equation?',
          'options': ['y²/36 - x²/16 = 1', 'x²/16 - y²/36 = 1', 'y²/16 - x²/36 = 1', 'x²/16 - y²/16 = 1'],
          'correctIndex': 0,
          'solution': 'SOLUTION: a=6, b=4 → y²/36 - x²/16 = 1',
          'image': '',
        },
        {
          'shape': 'Hyperbola',
          'question': ' Find the foci of (y+4)²/9 - (x-1)²/16 = 1',
          'options': ['(1,4±5)', '(1±5,4)', '(1,4±7)', '(1±7,4)'],
          'correctIndex': 0,
          'solution': 'SOLUTION: c=5 → foci at (1,-4±5)',
          'image': '',
        },
        {
          'shape': 'Hyperbola',
          'question': ' The equation 18x² - 9y² = 36 has eccentricity:',
          'options': ['5/3', '3/5', '√3', '5/6'],
          'correctIndex': 2,
          'solution': 'SOLUTION: e = c/a = √3',
          'image': '',
        },
        {
          'shape': 'Hyperbola',
          'question': ' A comet\'s path around the sun is modeled by:',
          'options': ['x² + y² = 1', 'y = x²', 'x²/9 - y²/16 = 1', 'x² + y²/4 = 1'],
          'correctIndex': 2,
          'solution': 'Answer: c) x²/9 - y²/16 = 1',
          'image': 'assets/comet_path.png',
        },
        {
          'shape': 'Hyperbola',
          'question': '10. A hyperbolic tower stands 150m tall. The width at narrowest point is:',
          'options': ['15m', '10m', '4m', '17m'],
          'correctIndex': 1,
          'solution': 'SOLUTION: a=5 → width=10 meters',
          'image': 'assets/hyperbolic_tower.png',
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
    if (imagePath == null || imagePath.isEmpty) return SizedBox.shrink();
    return Container(margin: EdgeInsets.symmetric(vertical: 5), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(4)), child: Image.asset(imagePath, width: 150, height: 80, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not available', style: TextStyle(color: Colors.grey)))));
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
                          if (answer['image'] != null && answer['image'].isNotEmpty) _buildQuestionImage(answer['image']),
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
