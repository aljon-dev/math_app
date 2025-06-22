import 'package:flutter/material.dart';
import 'package:math_app/Menu.dart';

class QuizScreenParabola extends StatefulWidget {
  @override
  _QuizScreenParabolaState createState() => _QuizScreenParabolaState();
}

class _QuizScreenParabolaState extends State<QuizScreenParabola> {
  final List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the standard form equation of a vertically opening parabola with vertex at the origin?',
      'options': ['a. (x - h)² = 4p(y - k)', 'b. y² = 4px', 'c. x² = 4py', 'd. (y - k)² = 4p(x - h)'],
      'correctIndex': 2,
      'solution': 'Answer: c. x² = 4py\n\nFor a vertical parabola with vertex at origin, the standard form is x² = 4py',
      'image': null,
    },
    {
      'question': ' The vertex of a parabola is the point that...',
      'options': ['a. Is the midpoint of the focus and directrix', 'b. Lies at the center of the parabola', 'c. Is always at (0,0)', 'd. Lies on the directrix'],
      'correctIndex': 0,
      'solution': 'Answer: a. Is the midpoint of the focus and directrix\n\nThe vertex is equidistant between the focus and directrix',
      'image': null,
    },
    {
      'question': ' What is the directrix of a parabola?',
      'options': ['a. A point inside the parabola', 'b. A fixed straight line used to define the parabola', 'c. The longest chord of the parabola', 'd. A line perpendicular to the axis of symmetry'],
      'correctIndex': 1,
      'solution': 'Answer: b. A fixed straight line used to define the parabola\n\nThe directrix is a fixed line that, with the focus, defines the parabola',
      'image': null,
    },
    {
      'question': ' The equation (y - 2)² = 8(x - 3) represents a parabola that opens...',
      'options': ['a. Upward', 'b. Downward', 'c. To the left', 'd. To the right'],
      'correctIndex': 3,
      'solution': 'Solution:\n4p = 8 → p = 2\nSince p > 0 and it\'s a y² equation, it opens to the right',
      'image': null,
    },
    {
      'question': ' Find the vertex of (y - 1)² = -4(x + 3)',
      'options': ['a. (3, -1)', 'b. (3, 1)', 'c. (-3, 1)', 'd. (-3, -1)'],
      'correctIndex': 2,
      'solution': 'Solution: (h, k) = (-3, 1)\nStandard form is (y - k)² = 4p(x - h)',
      'image': null,
    },
    {
      'question': ' Find the focus of (y - 1)² = -4(x + 3)',
      'options': ['a. (-4, 1)', 'b. (1, -4)', 'c. (-1, 4)', 'd. (-1, -4)'],
      'correctIndex': 0,
      'solution': 'Solution:\n4p = -4 → p = -1\nFocus = (h + p, k) = (-3 + (-1), 1) = (-4, 1)',
      'image': null,
    },
    {
      'question': 'Find the directrix of (y - 1)² = -4(x + 3)',
      'options': ['a. x = -2', 'b. x = 2', 'c. y = -2', 'd. y = 2'],
      'correctIndex': 0,
      'solution': 'Solution:\np = -1\nDirectrix: x = h - p = -3 - (-1) = -2',
      'image': null,
    },
    {
      'question': ' Find the latus rectum of (y - 1)² = -4(x + 3)',
      'options': ['a. 1 unit', 'b. 2 units', 'c. 3 units', 'd. 4 units'],
      'correctIndex': 3,
      'solution': 'Solution:\nLatus rectum = |4p| = |-4| = 4 units',
      'image': null,
    },
    {
      'question': ' Find the endpoints of latus rectum for (y - 1)² = -4(x + 3)',
      'options': ['a. E₁(4,3) and E₂(4,1)', 'b. E₁(-4,3) and E₂(-4,-1)', 'c. E₁(3,4) and E₂(1,4)', 'd. E₁(-3,4) and E₂(-1,-4)'],
      'correctIndex': 1,
      'solution': 'Solution:\np = -1\nEndpoints = (h - p, k ± 2p)\n= (-3 - (-1), 1 ± 2(-1))\n= (-4, 1 ± (-2))\n= (-4,3) and (-4,-1)',
      'image': null,
    },
    {
      'question': '. Write the equation of a parabola with vertex at (1,-3), opens right, and latus rectum of 8 units',
      'options': ['a. (x + 3)² = 8(y - 1)', 'b. (y + 3)² = 8(x - 1)', 'c. (x - 3)² = -8(y - 1)', 'd. (y + 3)² = -8(x - 1)'],
      'correctIndex': 1,
      'solution': 'Solution:\nStandard form: (y - k)² = 4p(x - h)\n4p = 8 → p = 2\nVertex (1,-3)\nEquation: (y + 3)² = 8(x - 1)',
      'image': null,
    },
  ];

  // Rest of your existing state management and UI code
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

    return Container(margin: EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)), child: Image.asset(imagePath, width: 200, height: 120, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey)))));
  }

  @override
  Widget build(BuildContext context) {
    if (questionOrder.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final originalIndex = questionOrder[currentQuestionIndex];
    final currentQuestion = questions[originalIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Parabola Quiz (${currentQuestionIndex + 1}/${questions.length})'), backgroundColor: Colors.purple, foregroundColor: Colors.white, actions: [Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Score: $score/${questions.length}', style: TextStyle(color: Colors.white))))]),
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
                    SizedBox(height: 20), // Add some spacing before the button
                  ],
                ),
              ),
            ),
          ),
          // Fixed button at the bottom
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MenuButton()));
          },
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
                          Text(answer['question']),
                          SizedBox(height: 8),
                          if (answer['image'] != null) Container(height: 100, child: Image.asset(answer['image'], fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => Center(child: Text('Image not found', style: TextStyle(color: Colors.grey))))),
                          SizedBox(height: 8),
                          Text('Your answer: ${answer['selected'] != null ? question['options'][answer['selected']] : 'Not answered'}', style: TextStyle(color: answer['isCorrect'] ? Colors.green.shade900 : Colors.red.shade900, fontWeight: FontWeight.w500)),
                          Text('Correct answer: ${question['options'][answer['correct']]}', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade900)),
                          SizedBox(height: 8),
                          Container(padding: EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(4)), child: Text('Solution: ${answer['solution']}', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 13, color: Colors.purple.shade800))),
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
          Positioned(right: 16, bottom: 100, child: Column(children: [FloatingActionButton(mini: true, onPressed: _currentScale < _maxScale ? _zoomIn : null, child: Icon(Icons.zoom_in)), SizedBox(height: 8), FloatingActionButton(mini: true, onPressed: _currentScale > _minScale ? _zoomOut : null, child: Icon(Icons.zoom_out))])),
        ],
      ),
    );
  }
}
