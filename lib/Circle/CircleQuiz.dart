import 'package:flutter/material.dart';
import 'dart:math';

import 'package:math_app/Menu.dart';

void main() {
  runApp(CircleQuizApp());
}

class CircleQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Circle Geometry Quiz', theme: ThemeData(primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity), home: QuizScreen());
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Questions list with ABCD options and solutions
  final List<Map<String, dynamic>> questions = [
    {
      'question': '1. What is the standard form equation of the circle if the radius is 15 and the center is (5,8)?',
      'options': ['a. (x-5)² + (y+8)² = 225', 'b. (x-5)² + (y-8)² = 225', 'c. (x+5)² + (y+8)² = 225', 'd. (x+5)² + (y+8)² = 225'],
      'correctIndex': 1,
      'solution': 'Using the standard form (x-h)² + (y-k)² = r² with h=5, k=8, r=15. Remember to change the signs of h and k!',
      'image': null,
    },
    {
      'question': '2. What is the center and radius of the circle (x+4)² + (y-7)² = 36?',
      'options': ['a. Center (2,4), radius=3', 'b. Center (-4,7), radius=6', 'c. Center (4,-7), radius=36', 'd. Center (-4,-7), radius=36²'],
      'correctIndex': 1,
      'solution': 'Standard form shows center at (-h,-k), so (-4,7). Radius is √36=6.',
      'image': null,
    },
    {
      'question': '3. What is the radius of the equation (x-7)² + (y-8)² = 49?',
      'options': ['a. 5', 'b. 7', 'c. 14', 'd. 48'],
      'correctIndex': 1,
      'solution': 'The equation is in standard form where r²=49, so r=√49=7.',
      'image': null,
    },
    {
      'question': '4. What is the Center for the general equation x² + y² + 4x + 2y - 4 = 0?',
      'options': ['a. (0,0)', 'b. (1,2)', 'c. (2,1)', 'd. (1,3)'],
      'correctIndex': 2,
      'solution': 'Complete the square: (x²+4x+4) + (y²+2y+1) = 4+4+1 → (x+2)² + (y+1)² = 9. Center is (-h,-k) = (2,1).',
      'image': null,
    },
    {
      'question': '5. What is the Radius for the general equation x² + y² + 4x + 2y - 4 = 0?',
      'options': ['a. 1', 'b. 2', 'c. 3', 'd. 4'],
      'correctIndex': 2,
      'solution': 'After completing the square: (x+2)² + (y+1)² = 9. Radius is √9=3.',
      'image': null,
    },
    {
      'question': '6. What is the general equation for (x+5)² + (y-2)² = 8²?',
      'options': ['a. x²-y²-10x-4y-35=0', 'b. x²+y²-10x-4y-35=0', 'c. x²+y²+10x-4y+35=0', 'd. x²+y²+10x-4y-35=0'],
      'correctIndex': 3,
      'solution': 'Expand: (x+5)²=x²+10x+25, (y-2)²=y²-4y+4. Combine: x²+y²+10x-4y+29=64 → x²+y²+10x-4y-35=0',
      'image': null,
    },
    {
      'question': '7. What is the Center for diameter endpoints at (-8,7) and (4,-3)?',
      'options': ['a. (-2,2)', 'b. (6,-5)', 'c. (5,8)', 'd. (-5,8)'],
      'correctIndex': 0,
      'solution': 'Midpoint formula: ((-8+4)/2, (7+(-3))/2) = (-2,2)',
      'image': null,
    },
    {
      'question': '8. A satellite orbits the earth in a circular path. If the two opposite points on its path are at coordinates (-4,6) and (8,-2), what is the center of its orbit?',
      'options': ['a. (-2,2)', 'b. (2,2)', 'c. (4,4)', 'd. (-4,4)'],
      'correctIndex': 1,
      'solution': 'Using midpoint formula: ((-4+8)/2 = 2, (6+(-2))/2 = 2) → Center at (2,2)',
      'image': 'assets/satellite_orbit.png',
    },
    {
      'question': '9. A park has a circular fountain with its center at (-3,2) and radius of 5 meters. What is the general form of the equation?',
      'options': ['a. x²+y²-6x+4y+12=0', 'b. x²+y²+6x-4y-12=0', 'c. x²+y²+6x-4y+12=0', 'd. x²+y²-6x+4y-12=0'],
      'correctIndex': 1,
      'solution': 'Standard form: (x+3)² + (y-2)² = 25 → Expanded: x²+6x+9 + y²-4y+4 = 25 → x²+y²+6x-4y-12=0',
      'image': 'assets/fountain.png',
    },
    {
      'question': '10. What is the center of the circle with diameter endpoints at (4,4) and (8,8)?',
      'options': ['a. (4,4)', 'b. (5,5)', 'c. (6,6)', 'd. (7,7)'],
      'correctIndex': 2,
      'solution': 'Midpoint: ((4+8)/2, (4+8)/2) = (6,6)',
      'image': null,
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
    if (!isAnswered) {
      setState(() {
        selectedOptionIndex = optionIndex;
        isAnswered = true;

        final originalIndex = questionOrder[currentQuestionIndex];
        userAnswers[originalIndex] = {...userAnswers[originalIndex], 'selected': optionIndex, 'isCorrect': optionIndex == questions[originalIndex]['correctIndex']};

        if (optionIndex == questions[originalIndex]['correctIndex']) {
          score++;
        }
      });
    }
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

  Color getOptionColor(int optionIndex) {
    if (!isAnswered) return Colors.white;
    final originalIndex = questionOrder[currentQuestionIndex];
    if (optionIndex == questions[originalIndex]['correctIndex']) {
      return Colors.green.shade100;
    } else if (optionIndex == selectedOptionIndex) {
      return Colors.red.shade100;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    if (questionOrder.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final originalIndex = questionOrder[currentQuestionIndex];
    final currentQuestion = questions[originalIndex];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButton()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Circle Geometry Quiz (${currentQuestionIndex + 1}/${questions.length})'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Score: $score/${questions.length}', style: TextStyle(color: Colors.white))))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(elevation: 4, child: Padding(padding: const EdgeInsets.all(16.0), child: Text(currentQuestion['question'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
            _buildZoomableImage(context, currentQuestion['image']),
            SizedBox(height: 20),
            ...List.generate(currentQuestion['options'].length, (index) {
              return Card(
                elevation: 2,
                color: getOptionColor(index),
                child: ListTile(
                  title: Text(currentQuestion['options'][index], style: TextStyle(fontSize: 16)),
                  onTap: () => answerQuestion(index),
                  leading: Icon(
                    isAnswered && index == selectedOptionIndex
                        ? (selectedOptionIndex == currentQuestion['correctIndex'] ? Icons.check_circle : Icons.cancel)
                        : isAnswered && index == currentQuestion['correctIndex']
                        ? Icons.check_circle
                        : Icons.radio_button_unchecked,
                    color:
                        isAnswered && index == currentQuestion['correctIndex']
                            ? Colors.green
                            : isAnswered && index == selectedOptionIndex
                            ? Colors.red
                            : Colors.grey,
                  ),
                ),
              );
            }),
            SizedBox(height: 20),
            if (isAnswered) Card(color: selectedOptionIndex == currentQuestion['correctIndex'] ? Colors.green.shade50 : Colors.red.shade50, child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [Text(selectedOptionIndex == currentQuestion['correctIndex'] ? '✓ Correct!' : '✗ Incorrect!', style: TextStyle(fontWeight: FontWeight.bold, color: selectedOptionIndex == currentQuestion['correctIndex'] ? Colors.green : Colors.red, fontSize: 20)), SizedBox(height: 10), Text('Solution: ${currentQuestion['solution']}', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14))]))),
            Spacer(),
            ElevatedButton(onPressed: isAnswered ? nextQuestion : null, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)), child: Text(currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }

  Widget _buildZoomableImage(BuildContext context, String? imagePath) {
    if (imagePath == null) return SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => _ZoomableImageScreen(imagePath: imagePath)));
      },
      child: Hero(tag: 'image-$imagePath', child: Image.asset(imagePath, height: 100, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey))))),
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

  const ResultsScreen({Key? key, required this.score, required this.totalQuestions, required this.userAnswers, required this.questionOrder, required this.questions, required this.onRestart}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButton()));
          },
        ),
        title: Text('Quiz Results'),
        backgroundColor: Colors.blue,
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
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(Icons.emoji_events, size: 60, color: Colors.blue),
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
                itemBuilder: (context, displayIndex) {
                  final originalIndex = questionOrder[displayIndex];
                  final answer = userAnswers[originalIndex];
                  final question = questions[originalIndex];

                  return Card(
                    margin: EdgeInsets.only(bottom: 10),
                    elevation: 3,
                    color: answer['isCorrect'] ? Colors.green.shade50 : Colors.red.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [Icon(answer['isCorrect'] ? Icons.check_circle : Icons.cancel, color: answer['isCorrect'] ? Colors.green : Colors.red, size: 20), SizedBox(width: 8), Expanded(child: Text('Question ${displayIndex + 1}', style: TextStyle(fontWeight: FontWeight.bold, color: answer['isCorrect'] ? Colors.green.shade900 : Colors.red.shade900, fontSize: 16)))]),
                          SizedBox(height: 8),
                          Text(answer['question'], style: TextStyle(fontSize: 14)),
                          SizedBox(height: 8),
                          if (answer['image'] != null) Container(height: 100, child: Image.asset(answer['image'], fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey))))),
                          SizedBox(height: 8.0),
                          Text('Your answer: ${answer['selected'] != null ? question['options'][answer['selected']] : 'Not answered'}', style: TextStyle(color: answer['isCorrect'] ? Colors.green.shade900 : Colors.red.shade900, fontWeight: FontWeight.w500)),
                          Text('Correct answer: ${question['options'][answer['correct']]}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900)),
                          SizedBox(height: 8),
                          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)), child: Text('Solution: ${answer['solution']}', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13, color: Colors.blue.shade800))),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.refresh), SizedBox(width: 8), Text('Restart Quiz', style: TextStyle(fontSize: 18))]),
            ),
          ],
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
                // Update current scale when user uses touch zoom
                setState(() {
                  _currentScale = _controller.value.getMaxScaleOnAxis();
                });
              },
              child: Image.asset(height: double.infinity, width: double.infinity, widget.imagePath, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))),
            ),
          ),
          // Zoom control buttons
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
