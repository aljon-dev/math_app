import 'package:flutter/material.dart';
import 'dart:math';

import 'package:math_app/Menu.dart';

class QuizScreenHyperBola extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreenHyperBola> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': ' What are the asymptotes of the hyperbola x²/25 - y²/81 = 1?',
      'options': ['a. y = ± (5/9)x', 'b. y = ± (9/5)x', 'c. y = ± (4/9)x', 'd. y = ± (9/4)x'],
      'correctIndex': 1,
      'solution': 'Solution:\n\na² = 25 → a = 5\nb² = 81 → b = 9\n\nAsymptotes formula: y = ±(b/a)x\n= ±(9/5)x',
      'image': null,
    },
    {
      'question': ' Give the coordinates of foci in hyperbola (y-9)²/10 - (x-6)²/6 = 1',
      'options': ['a. F(6, 13), (6, 5)', 'b. F(-6, 10), (6, -10)', 'c. F(9, 10), (9, 13)', 'd. F(6, -13), (9, -5)'],
      'correctIndex': 0,
      'solution': 'Solution:\n\nVertical hyperbola\na² = 10 → a = √10\nb² = 6 → b = √6\nc² = a² + b² = 16 → c = 4\n\nCenter at (6,9)\nFoci at (h,k±c) = (6,9±4)\n= (6,13) and (6,5)',
      'image': null,
    },
    {
      'question': ' What is the length of the transverse axis of x²/4 - y²/16 = 1?',
      'options': ['a. 2', 'b. 4', 'c. 8', 'd. 6'],
      'correctIndex': 1,
      'solution': 'Solution:\n\na² = 4 → a = 2\nTransverse axis length = 2a = 4',
      'image': null,
    },
    {
      'question': ' Convert 4x² - 9y² - 16x + 54y = 137 to standard form',
      'options': ['a. (x-2)²/15 - (y-7)²/9 = 1', 'b. (x-2)²/18 - (y-3)²/8 = 1', 'c. (x-4)²/6 - (y-9)²/18 = 1', 'd. (x-4)²/18 - (y-8)²/15 = 1'],
      'correctIndex': 1,
      'solution': 'Solution:\n\nComplete squares:\n4(x²-4x+4) - 9(y²-6y+9) = 137 + 16 - 81\n4(x-2)² - 9(y-3)² = 72\nDivide by 72:\n(x-2)²/18 - (y-3)²/8 = 1',
      'image': null,
    },
    {
      'question': ' Find c of y² - 25x² = 25',
      'options': ['a. c = 5', 'b. c = √32', 'c. c = √26', 'd. c = 15'],
      'correctIndex': 2,
      'solution': 'Solution:\n\nDivide by 25:\ny²/25 - x²/1 = 1\na² = 25 → a = 5\nb² = 1 → b = 1\nc² = a² + b² = 26 → c = √26',
      'image': null,
    },
    {
      'question': ' Length of conjugate axis for y²/225 - x²/100 = 1?',
      'options': ['a. 25', 'b. 20', 'c. 50', 'd. 10'],
      'correctIndex': 1,
      'solution': 'Solution:\n\nb² = 100 → b = 10\nConjugate axis length = 2b = 20',
      'image': null,
    },
    {
      'question': ' Standard form with vertices at (0,±9) passing through (8,15)',
      'options': ['a. y²/78 - x²/40 = 1', 'b. y²/81 - x²/36 = 1', 'c. y²/67 - x²/36 = 1', 'd. y²/90 - x²/40 = 1'],
      'correctIndex': 1,
      'solution': 'Solution:\n\na = 9 → a² = 81\nPlug (8,15):\n15²/81 - 8²/b² = 1\nSolve for b² = 36\nEquation: y²/81 - x²/36 = 1',
      'image': null,
    },
    {
      'question': ' The tower stands 198 meters tall, Find the width of the tower at the narrowest part in the middle using the equation x^2/36-y^2/484= 1.?',
      'options': ['a. 15 meters', 'b. 12 meters', 'c. 4 meters', 'd. 17 meters'],
      'correctIndex': 1,
      'solution': 'Solution:\n\na² = 36 → a = 6\nWidth at narrowest = 2a = 12 meters',
      'image': null,
    },
    {
      'question': ' An explosion is heard by the two station 1000m apart, located at F² (, -400,0) and F¹ (400,0). If the explosion was heard in F¹ two seconds before it was heard in F², identify the possible location of the explosion. Use 220 m/s as their speed of sound.',
      'options': ['a. x²/746562 - y²/123678 = 1', 'b. x²/34322 - y²/178682 = 1', 'c. x²/48400 - y²/111600 = 1', 'd. x²/45758 - y²/374276 = 1'],
      'correctIndex': 2,
      'solution': 'Solution:\n\n2a = 220×2 = 440 → a = 220\na² = 48400\nc = 400 (half distance between stations)\nb² = c² - a² = 160000 - 48400 = 111600\nEquation: x²/48400 - y²/111600 = 1',
      'image': 'assets/hyperbola_stations.png',
    },
    {
      'question': ' The hyperbolic design of power plant can be modeled by x^2/36 - y^2/256 = 1, and its height is 180 m tall. Determine the width at the top of a power plant?',
      'options': ['a. x ≈ 39.8 meters', 'b. x ≈ 34.28 meters', 'c. x ≈ 35.82 meters', 'd. x ≈ 38.8 meters'],
      'correctIndex': 1,
      'solution': 'Solution:\n\nAt height y=90 (half of 180):\nx²/36 - 90²/256 = 1\nx²/36 = 1 + 31.64\nx² = 32.64 × 36 ≈ 1175\nx ≈ √1175 ≈ 34.28 meters',
      'image': 'assets/hyperbola_powerplant.png',
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

  Widget _buildQuestionImage(String? imagePath) {
    if (imagePath == null) return SizedBox.shrink();

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Scaffold(appBar: AppBar(title: Text('Image Preview')), body: Center(child: InteractiveViewer(panEnabled: true, minScale: 0.5, maxScale: 4.0, child: Image.asset(imagePath, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))))))));
      },
      child: Hero(tag: 'image-$imagePath', child: Container(margin: EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)), child: Image.asset(imagePath, width: 200, height: 120, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))))),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (questionOrder.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final originalIndex = questionOrder[currentQuestionIndex];
    final currentQuestion = questions[originalIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Hyperbola Quiz (${currentQuestionIndex + 1}/${questions.length})'), backgroundColor: Colors.purple, foregroundColor: Colors.white, actions: [Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Score: $score/${questions.length}', style: TextStyle(color: Colors.white))))]),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(elevation: 4, child: Padding(padding: const EdgeInsets.all(16.0), child: Text(currentQuestion['question'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
                    _BuildZoomableImage(context, currentQuestion['image']),
                    SizedBox(height: 20),
                    ...List.generate(currentQuestion['options'].length, (index) {
                      return Card(
                        elevation: 2,
                        color: getOptionColor(index),
                        child: ListTile(
                          title: Text(currentQuestion['options'][index]),
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
                    if (isAnswered) Card(color: selectedOptionIndex == currentQuestion['correctIndex'] ? Colors.green.shade50 : Colors.red.shade50, child: Padding(padding: const EdgeInsets.all(16.0), child: Column(children: [Text(selectedOptionIndex == currentQuestion['correctIndex'] ? '✓ Correct!' : '✗ Incorrect!', style: TextStyle(fontWeight: FontWeight.bold, color: selectedOptionIndex == currentQuestion['correctIndex'] ? Colors.green : Colors.red, fontSize: 20)), SizedBox(height: 10), Text(currentQuestion['solution'], style: TextStyle(fontSize: 14))]))),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(16.0), child: ElevatedButton(onPressed: isAnswered ? nextQuestion : null, style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)), child: Text(currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz', style: TextStyle(fontSize: 18)))),
        ],
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
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButton()));
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
            Card(
              elevation: 8,
              color: Colors.purple.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Icon(Icons.emoji_events, size: 60, color: Colors.purple),
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
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)),
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
