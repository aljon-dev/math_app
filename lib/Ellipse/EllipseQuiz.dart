import 'package:flutter/material.dart';
import 'dart:math';

class QuizScreenEllipse extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreenEllipse> {
  // Questions list with ABCD options and solutions
  final List<Map<String, dynamic>> questions = [
    {
      'question': '1. In an ellipse, the longest axis is called:',
      'options': ['a. eccentricity', 'b. minor axis', 'c. major axis', 'd. conjugate axis'],
      'correctIndex': 2,
      'solution': 'The major axis is the longest diameter of an ellipse, passing through both foci and the center.',
      'image': null,
    },
    {
      'question': '2. An ellipse has _____ vertices and _____ foci.',
      'options': ['a. two, two', 'b. one, two', 'c. two, one', 'd. one, one'],
      'correctIndex': 0,
      'solution': 'An ellipse has exactly two vertices (endpoints of major axis) and two foci (fixed points).',
      'image': null,
    },
    {
      'question': '3. The two fixed points in the ellipse are called ____.',
      'options': ['a. Co-vertices', 'b. Vertices', 'c. Foci', 'd. Latus Rectum'],
      'correctIndex': 2,
      'solution': 'The foci are the two fixed points that define an ellipse. The sum of distances from any point on the ellipse to both foci is constant.',
      'image': null,
    },
    {
      'question': '4. The endpoints of the minor axis of an ellipse are called:',
      'options': ['a. Foci', 'b. Vertices', 'c. Co-vertices', 'd. Center'],
      'correctIndex': 2,
      'solution': 'Co-vertices are the endpoints of the minor axis, which is the shorter diameter of the ellipse.',
      'image': null,
    },
    {
      'question': '5. What are the coordinates of the foci for an ellipse with a horizontal major axis centered at (0,0)?',
      'options': ['a. (0, ±c)', 'b. (±c, 0)', 'c. (h, k±c)', 'd. (h±a, c)'],
      'correctIndex': 1,
      'solution': 'For a horizontal ellipse centered at origin, foci are at (±c, 0) where c² = a² - b².',
      'image': null,
    },
    {
      'question': '6. The line segments perpendicular to the major axis through any of the foci such that their endpoints lie on the ellipse:',
      'options': ['a. Latus Rectum', 'b. Directrix', 'c. Eccentricity', 'd. Conjugate axis'],
      'correctIndex': 0,
      'solution': 'The latus rectum is a chord through a focus perpendicular to the major axis. Its length is 2b²/a.',
      'image': null,
    },
    {
      'question': '7. What are the foci of an ellipse with equation x²/100 + y²/169 = 1?',
      'options': ['a. (0, ±5√2)', 'b. (0, ±√73)', 'c. (0, ±√69)', 'd. (0, ±√13)'],
      'correctIndex': 2,
      'solution': 'a² = 169, b² = 100. Since a > b, major axis is vertical. c² = a² - b² = 169 - 100 = 69, so c = √69. Foci: (0, ±√69)',
      'image': null,
    },
    {
      'question': '8. What is eccentricity for x²/25 + y²/16 = 1?',
      'options': ['a. 5/4', 'b. 4/5', 'c. 2/5', 'd. 3/5'],
      'correctIndex': 3,
      'solution': 'a² = 25, b² = 16, so a = 5, b = 4. c² = a² - b² = 25 - 16 = 9, so c = 3. Eccentricity = c/a = 3/5.',
      'image': null,
    },
    {
      'question': '9. What is the length of latus rectum for x²/144 + y²/49 = 1?',
      'options': ['a. 27/4', 'b. 49/6', 'c. 12/7', 'd. 19/9'],
      'correctIndex': 1,
      'solution': 'a² = 144, b² = 49, so a = 12, b = 7. Latus rectum = 2b²/a = 2(49)/12 = 98/12 = 49/6.',
      'image': null,
    },
    {
      'question': '10. If length of major axis is 10 and minor axis is 8, with major axis along x-axis, find the equation.',
      'options': ['a. x²/10 + y²/8 = 1', 'b. x²/8 + y²/10 = 1', 'c. x²/16 + y²/25 = 1', 'd. x²/25 + y²/16 = 1'],
      'correctIndex': 3,
      'solution': 'Major axis = 2a = 10, so a = 5. Minor axis = 2b = 8, so b = 4. Since major axis is along x-axis: x²/25 + y²/16 = 1.',
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
      appBar: AppBar(title: Text('Ellipse Geometry Quiz (${currentQuestionIndex + 1}/${questions.length})'), backgroundColor: Colors.purple, foregroundColor: Colors.white, actions: [Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Score: $score/${questions.length}', style: TextStyle(color: Colors.white))))]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(elevation: 4, child: Padding(padding: const EdgeInsets.all(16.0), child: Text(currentQuestion['question'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)))),
            _buildQuestionImage(currentQuestion['image']),
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
            ElevatedButton(onPressed: isAnswered ? nextQuestion : null, style: ElevatedButton.styleFrom(backgroundColor: Colors.purple, foregroundColor: Colors.white, minimumSize: Size(double.infinity, 50)), child: Text(currentQuestionIndex < questions.length - 1 ? 'Next Question' : 'Finish Quiz', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
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
