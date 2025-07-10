import 'package:flutter/material.dart';
import 'dart:math';

import 'package:math_app/Menu.dart';

class QuizScreenEllipse extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreenEllipse> {
  // Questions list with ABCD options and solutions
  final List<Map<String, dynamic>> questions = [
    {
      'question': ' The line segments perpendicular to the major axis through any of the foci such that their endpoints lie on the ellipse',
      'options': ['a. Latus Rectum', 'b. Directrix', 'c. Eccentricity', 'd. Conjugate axis'],
      'correctIndex': 0,
      'solution': 'The latus rectum is a chord through a focus perpendicular to the major axis. Its length is 2b²/a.',
      'image': null,
    },
    {
      'question': ' What are the foci of an ellipse with an equation of x²/100 + y²/169 = 1?',
      'options': ['a. (0, ±5√2)', 'b. (0, ±√73)', 'c. (0, ±√69)', 'd. (0, ±√13)'],
      'correctIndex': 2,
      'solution': 'a² = 169, b² = 100. Since a > b, major axis is vertical. c² = a² - b² = 169 - 100 = 69, so c = √69. Foci: (0, ±√69)',
      'image': null,
    },
    {
      'question': ' What is eccentricity for x²/25 + y²/16 = 1?',
      'options': ['a. 5/4', 'b. 4/5', 'c. 2/5', 'd. 3/5'],
      'correctIndex': 3,
      'solution': 'a² = 25, b² = 16, so a = 5, b = 4. c² = a² - b² = 25 - 16 = 9, so c = 3. Eccentricity = c/a = 3/5.',
      'image': null,
    },
    {
      'question': ' What is the length of latus rectum for x²/144 + y²/49 = 1?',
      'options': ['a. 27/4', 'b. 49/6', 'c. 12/7', 'd. 19/9'],
      'correctIndex': 1,
      'solution': 'a² = 144, b² = 49, so a = 12, b = 7. Latus rectum = 2b²/a = 2(49)/12 = 98/12 = 49/6.',
      'image': null,
    },
    {
      'question': 'If length of major axis is 10 and minor axis is 8 and major axis is along x-axis then find the equation of ellipse.',
      'options': ['a. x²/10 + y²/8 = 1', 'b. x²/8 + y²/10 = 1', 'c. x²/16 + y²/25 = 1', 'd. x²/25 + y²/16 = 1'],
      'correctIndex': 3,
      'solution': 'Major axis = 2a = 10, so a = 5. Minor axis = 2b = 8, so b = 4. Since major axis is along x-axis: x²/25 + y²/16 = 1.',
      'image': null,
    },
    {
      'question': ' If foci of an ellipse are (0, ±6) and length of semi-major axis is 10 units, then find the equation of ellipse.',
      'options': ['a. x²/64 + y²/100 = 1', 'b. x²/10 + y²/8 = 1', 'c. x²/6 + y²/10 = 1', 'd. x²/10 + y²/6 = 1'],
      'correctIndex': 0,
      'solution': 'Foci: (0, ±6), so c = 6. Semi-major axis a = 10. Since foci are vertical, major axis is along y-axis. c² = a² - b², so 36 = 100 - b², therefore b² = 64. Equation: x²/64 + y²/100 = 1.',
      'image': null,
    },
    {
      'question': ' Which of the following equations satisfy the condition as eccentricity e = √3/2?',
      'options': ['a. x² + 4y² + 6x - 8y + 9 = 0', 'b. 2x - y² - 8x + 5y - 6 = 0', 'c. 2x² - y² + 4x + 18y - 2 = 0', 'd. x² + y² + 12x - 6y + 10 = 0'],
      'correctIndex': 0,
      'solution': 'Converting to standard form: (x+3)²/4 + (y-1)²/1 = 1. Here a² = 4, b² = 1, so c² = 4-1 = 3, c = √3. Eccentricity = c/a = √3/2.',
      'image': null,
    },
    {
      'question': 'If an ellipse has foci at (±5, 0) and vertices at (±7, 0), what is its eccentricity?',
      'options': ['a. 7/5', 'b. 5/7', 'c. 12/7', 'd. 7/12'],
      'correctIndex': 1,
      'solution': 'Foci: (±5, 0), so c = 5. Vertices: (±7, 0), so a = 7. Eccentricity = c/a = 5/7.',
      'image': null,
    },
    {
      'question': ' Which graph correctly represents the equation (x-4)²/49 + (y+3)²/64 = 1?',
      'options': ['a. Graph A', 'b. Graph B', 'c. Graph C', 'd. Graph D'],
      'correctIndex': 0,
      'solution': 'Center: (4, -3). a² = 64, b² = 49, so a = 8, b = 7. Since a² > b², major axis is vertical with length 16, minor axis horizontal with length 14.',
      'image': 'assets/images/question14_graphs.jpg',
    },
    {
      'question': ' What are the vertices of the ellipse shown in the graph?',
      'options': ['a. (-5, 15) and (-5, -1)', 'b. (-11, 7) and (1, 7)', 'c. (-5, 7) and (1, 7)', 'd. (15, -5) and (1, 5)'],
      'correctIndex': 0,
      'solution': 'From the graph, the center appears to be at (-5, 7). The major axis is vertical, and counting units from center to endpoints of major axis gives vertices at (-5, 15) and (-5, -1).',
      'image': 'assets/images/question15_ellipse.png',
    },
  ];

  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  bool isAnswered = false;
  int score = 0;
  List<int> questionOrder = [];
  List<Map<String, dynamic>> userAnswers = [];

  @override
  void initState() {
    super.initState();
    resetQuiz();
  }

  void resetQuiz() {
    setState(() {
      questionOrder = List.generate(questions.length, (index) => index)..shuffle();
      currentQuestionIndex = 0;
      selectedOptionIndex = null;
      isAnswered = false;
      score = 0;
      userAnswers = List.generate(questions.length, (index) => {'question': questions[index]['question'], 'selected': null, 'correct': questions[index]['correctIndex'], 'solution': questions[index]['solution'], 'isCorrect': false, 'image': questions[index]['image']});
    });
  }

  void answerQuestion(int optionIndex) {
    setState(() {
      selectedOptionIndex = optionIndex;

      final originalIndex = questionOrder[currentQuestionIndex];
      userAnswers[originalIndex] = {...userAnswers[originalIndex], 'selected': optionIndex, 'isCorrect': optionIndex == questions[originalIndex]['correctIndex']};

      if (optionIndex == questions[originalIndex]['correctIndex']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        isAnswered = false;
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ResultsScreen(score: score, totalQuestions: questions.length, userAnswers: userAnswers, questionOrder: questionOrder, questions: questions, onRestart: resetQuiz)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questionOrder.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final originalIndex = questionOrder[currentQuestionIndex];
    final currentQuestion = questions[originalIndex];

    return WillPopScope(
      onWillPop: () async {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MenuButton()));
    return false; // 
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButton()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Ellipse Quiz(${currentQuestionIndex + 1}/${questions.length})'),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(elevation: 4, child: Padding(padding: const EdgeInsets.all(16.0), child: Text(currentQuestion['question'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                _BuildZoomableImage(context, currentQuestion['image']),
                SizedBox(height: 20),
                ...List.generate(currentQuestion['options'].length, (index) {
                  return Card(elevation: 2, child: ListTile(title: Text(currentQuestion['options'][index], style: TextStyle(fontSize: 16)), onTap: () => answerQuestion(index), leading: Icon(selectedOptionIndex == index ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: selectedOptionIndex == index ? Colors.blue : Colors.grey)));
                }),
                SizedBox(height: 20),
                ElevatedButton(onPressed: selectedOptionIndex != null ? nextQuestion : null, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)), child: Text(currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz', style: TextStyle(fontSize: 18))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _BuildZoomableImage(BuildContext context, String? imagePath) {
    if (imagePath == null) return SizedBox.shrink();
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => _ZoomableImageScreen(imagePath: imagePath)));
      },
      child: Hero(tag: 'image-$imagePath', child: Image.asset(imagePath, height: 100, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image Not FOund ', style: TextStyle(color: Colors.grey))))),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final List<Map<String, dynamic>> userAnswers;
  final List<int> questionOrder;
  final List<Map<String, dynamic>> questions;
  final VoidCallback onRestart;

  const ResultsScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.userAnswers,
    required this.questionOrder,
    required this.questions,
    required this.onRestart,
  }) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MenuButton()));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuButton()));
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('Quiz Results'),
          backgroundColor: Colors.purple,
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
              // Wider score box
              Container(
                width: double.infinity,  // Changed from 180 to double.infinity
                padding: EdgeInsets.all(20),  // Increased padding
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.emoji_events,
                        size: 50, color: Colors.purple),  // Increased icon size
                    SizedBox(height: 12),  // Increased spacing
                    Text(
                      'Your Quiz Score',
                      style: TextStyle(
                        fontSize: 16,  // Increased font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '$score/$totalQuestions',
                      style: TextStyle(
                        fontSize: 20,  // Increased font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 10,  // Increased height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300,
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: score / totalQuestions,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: _getGradeColor(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                   
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: totalQuestions,
                  itemBuilder: (context, displayIndex) {
                    final originalIndex = questionOrder[displayIndex];
                    final answer = userAnswers[originalIndex];
                    final question = questions[originalIndex];
                    final isCorrect = answer['isCorrect'];

                    return Card(
                      margin: EdgeInsets.only(bottom: 10),
                      elevation: 3,
                      color: isCorrect
                          ? Colors.green.shade50
                          : Colors.red.shade50,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: isCorrect
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: isCorrect
                                        ? Colors.green
                                        : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    isCorrect
                                        ? Icons.check
                                        : Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Question ${displayIndex + 1}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: isCorrect
                                          ? Colors.green.shade900
                                          : Colors.red.shade900,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              answer['question'],
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 8),
                            if (answer['image'] != null)
                              Container(
                                height: 100,
                                child: Image.asset(
                                  answer['image'],
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Center(
                                    child: Text(
                                      'Image not found',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Your answer: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: answer['selected'] != null
                                        ? question['options'][answer['selected']]
                                        : 'Not answered',
                                    style: TextStyle(
                                      color: isCorrect
                                          ? Colors.green.shade900
                                          : Colors.red.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 4),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Correct answer: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: question['options'][answer['correct']],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.blue.shade100,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Solution: ${answer['solution']}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 13,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh),
                    SizedBox(width: 8),
                    Text('Restart Quiz', style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class _ZoomableImageScreen extends StatefulWidget {
  final String imagePath;

  const _ZoomableImageScreen({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<_ZoomableImageScreen> createState() => _ZoombaleStateImageScreenState();
}

class _ZoombaleStateImageScreenState extends State<_ZoomableImageScreen> {
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
      appBar: AppBar(title: Text('Image Preview'), actions: [IconButton(onPressed: _resetZoom, icon: Icon(Icons.refresh))]),
      body: Stack(
        children: [
          Center(
            child: InteractiveViewer(
              transformationController: _controller,
              minScale: _minScale,
              maxScale: _maxScale,
              onInteractionUpdate: (details) {
                setState(() {
                  _currentScale = _controller.value.getMaxScaleOnAxis();
                });
              },
              child: Image.asset(widget.imagePath, width: double.infinity, height: double.infinity, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 100,
            child: Column(
              children: [
                FloatingActionButton(mini: true, onPressed: _currentScale < _maxScale ? _zoomIn : null, child: Icon(Icons.zoom_in), backgroundColor: _currentScale < _maxScale ? Theme.of(context).primaryColor : Colors.grey),
                SizedBox(height: 8),
                FloatingActionButton(mini: true, onPressed: _currentScale > _minScale ? _zoomOut : null, child: Icon(Icons.zoom_out), backgroundColor: _currentScale > _minScale ? Theme.of(context).primaryColor : Colors.grey),
                SizedBox(height: 8),
                // Zoom level indicator
                Container(padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(12)), child: Text('${(_currentScale * 100).round()}%', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
