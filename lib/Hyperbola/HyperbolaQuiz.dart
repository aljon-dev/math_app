import 'package:flutter/material.dart';
import 'dart:math';

class QuizScreenHyperBola extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreenHyperBola> {
  // Questions list with ABCD options and solutions
  final List<Map<String, dynamic>> questions = [
    {
      'question': '1. What are the asymptotes of the hyperbola x²/25 - y²/81 = 1?',
      'options': ['a. y = ± (5/9)x', 'b. y = ± (9/5)x', 'c. y = ± (4/9)x', 'd. y = ± (9/4)x'],
      'correctIndex': 1,
      'solution': 'Find a² = 25, so a = 5; b² = 81, so b = 9. Use formula y = ±(b/a)x = ±(9/5)x.',
      'image': null,
    },
    {
      'question': '2. Give the coordinates of foci in hyperbola (y-9)²/10 - (x-6)²/6 = 1.',
      'options': ['a. F(6, 13), (6, 5)', 'b. F(-6, 10), (6, -10)', 'c. F(9, 10), (9, 13)', 'd. F(6, -13), (9, -5)'],
      'correctIndex': 0,
      'solution': 'Vertical hyperbola: a² = 10, b² = 6, c² = a² + b² = 16, so c = 4. Foci at (h, k±c) = (6, 9±4) = (6,13) and (6,5).',
      'image': null,
    },
    {
      'question': '3. What is the length of the transverse axis of the hyperbola x²/4 - y²/16 = 1?',
      'options': ['a. 2', 'b. 4', 'c. 8', 'd. 6'],
      'correctIndex': 1,
      'solution': 'Length of transverse axis = 2a. From a² = 4, we get a = 2. Therefore, 2a = 2(2) = 4.',
      'image': null,
    },
    {
      'question': '4. Convert 4x² - 9y² - 16x + 54y = 137 to standard form.',
      'options': ['a. (x-2)²/15 - (y-7)²/9 = 1', 'b. (x-2)²/18 - (y-3)²/8 = 1', 'c. (x-4)²/6 - (y-9)²/18 = 1', 'd. (x-4)²/18 - (y-8)²/15 = 1'],
      'correctIndex': 1,
      'solution': 'Complete the square: 4(x²-4x) - 9(y²-6y) = 137. Add 4(4) - 9(9) to get 4(x-2)² - 9(y-3)² = 72, then divide by 72.',
      'image': null,
    },
    {
      'question': '5. Find c of the general equation y² - 25x² = 25.',
      'options': ['a. c = 5', 'b. c = √32', 'c. c = √26', 'd. c = 15'],
      'correctIndex': 2,
      'solution': 'Standard form: y²/25 - x²/1 = 1. So a² = 25, b² = 1. Therefore c² = a² + b² = 25 + 1 = 26, so c = √26.',
      'image': null,
    },
    {
      'question': '6. What is the length of the conjugate axis if the equation is y²/225 - x²/100 = 1?',
      'options': ['a. 25', 'b. 20', 'c. 50', 'd. 10'],
      'correctIndex': 1,
      'solution': 'Length of conjugate axis = 2b. From b² = 100, we get b = 10. Therefore, 2b = 2(10) = 20.',
      'image': null,
    },
    {
      'question': '7. Find the standard form for a hyperbola with vertices at (0, ±9) passing through (8,15).',
      'options': ['a. y²/78 - x²/40 = 1', 'b. y²/81 - x²/36 = 1', 'c. y²/67 - x²/36 = 1', 'd. y²/90 - x²/40 = 1'],
      'correctIndex': 1,
      'solution': 'a = 9, so a² = 81. Substitute point (8,15): 15²/81 - 8²/b² = 1. Solve for b²: b² = 64×81/(225-81) = 36.',
      'image': null,
    },
    {
      'question': '8. A tower 198m tall has equation x²/36 - y²/484 = 1. Find width at narrowest part.',
      'options': ['a. 15 meters', 'b. 12 meters', 'c. 4 meters', 'd. 17 meters'],
      'correctIndex': 1,
      'solution': 'Width at narrowest part = 2a. From a² = 36, we get a = 6. Therefore, width = 2(6) = 12 meters.',
      'image': null,
    },
    {
      'question': '9. Two stations 1000m apart hear explosion. F₁ hears it 2s before F₂. Speed of sound = 220 m/s. Find equation.',
      'options': ['a. x²/746562 - y²/123678 = 1', 'b. x²/34322 - y²/178682 = 1', 'c. x²/48400 - y²/111600 = 1', 'd. x²/45758 - y²/374276 = 1'],
      'correctIndex': 2,
      'solution': 'Distance difference = 220×2 = 440, so 2a = 440, a = 220. c = 400 (half distance). b² = c² - a² = 160000 - 48400 = 111600.',
      'image': null,
    },
    {
      'question': '10. Power plant height 180m, equation x²/36 - y²/256 = 1. Find width at top.',
      'options': ['a. x ≈ 39.8 meters', 'b. x ≈ 34.28 meters', 'c. x ≈ 35.82 meters', 'd. x ≈ 38.8 meters'],
      'correctIndex': 1,
      'solution': 'At y = 90: x²/36 - 90²/256 = 1. Solve: x²/36 = 1 + 31.65 = 32.65, so x² = 1175.4, x ≈ 34.28 meters.',
      'image': null,
    },
    {
      'question': '11. What is the equation of hyperbola with center (h,k) and transverse axis parallel to y-axis?',
      'options': ['a. Ax² + By² + Cx + Dy + E = 0', 'b. (y-k)²/a² - (x-h)²/b² = 1', 'c. (x-h)²/a² - (y-k)²/b² = 1', 'd. Ax² - By² - Cx - Dy - E = 0'],
      'correctIndex': 1,
      'solution': 'For vertical transverse axis, the y-term is positive: (y-k)²/a² - (x-h)²/b² = 1.',
      'image': null,
    },
    {
      'question': '12. Find vertices of (y-8)²/9 - (x-4)²/16 = 1.',
      'options': ['a. V(4, 13), (-4, 3)', 'b. V(-3, 10), (3, 3)', 'c. V(4, 11), (4, 5)', 'd. V(-4, -10), (-4, 3)'],
      'correctIndex': 2,
      'solution': 'Vertical hyperbola with center (4,8). a² = 9, so a = 3. Vertices at (h, k±a) = (4, 8±3) = (4,11) and (4,5).',
      'image': null,
    },
    {
      'question': '13. Determine center of 9x² - 2y² + 54x + 4y - 11 = 0.',
      'options': ['a. (-3, 1)', 'b. (3, 2)', 'c. (-3, -2)', 'd. (-1, 3)'],
      'correctIndex': 0,
      'solution': 'Complete the square: 9(x² + 6x) - 2(y² - 2y) = 11. Add 9(9) - 2(1) to get 9(x+3)² - 2(y-1)² = 90. Center is (-3,1).',
      'image': null,
    },
    {
      'question': '14. Transform (x-4)²/4 - (y-5)²/25 = 1 to general form.',
      'options': ['a. 20x² + 4y² + 200x + 50y + 50 = 0', 'b. -25x² + 4y² + 100x + 40y + 50 = 0', 'c. 20x² - 4y² + 100x + 20y + 200 = 0', 'd. 25x² - 4y² - 200x + 40y + 200 = 0'],
      'correctIndex': 3,
      'solution': 'Multiply by 100: 25(x-4)² - 4(y-5)² = 100. Expand and rearrange: 25x² - 4y² - 200x + 40y + 200 = 0.',
      'image': null,
    },
    {
      'question': '15. Cooling tower equation x²/9 - y²/121 = 1. Find width at narrowest part.',
      'options': ['a. 8 meters', 'b. 6 meters', 'c. 10 meters', 'd. 12 meters'],
      'correctIndex': 1,
      'solution': 'Width at narrowest part = 2a. From a² = 9, we get a = 3. Therefore, width = 2(3) = 6 meters.',
      'image': null,
    },
    {
      'question': '16. Hyperbola with vertices (0, ±6) and asymptotes y = ±(3/2)x. Find equation.',
      'options': ['a. y²/36 - x²/16 = 1', 'b. x²/16 - y²/36 = 1', 'c. y²/16 - x²/36 = 1', 'd. x²/16 - y²/16 = 1'],
      'correctIndex': 0,
      'solution': 'Vertical hyperbola: a = 6, so a² = 36. From asymptote a/b = 3/2: 6/b = 3/2, so b = 4, b² = 16.',
      'image': null,
    },
    {
      'question': '17. Find foci of (y+4)²/9 - (x-1)²/16 = 1.',
      'options': ['a. (1, -4 ± 5)', 'b. (1 ± 5, -4)', 'c. (1, -4 ± 7)', 'd. (1 ± 7, -4)'],
      'correctIndex': 0,
      'solution': 'Center (1,-4). a² = 9, b² = 16, so c² = 9 + 16 = 25, c = 5. Foci at (h, k±c) = (1, -4±5).',
      'image': null,
    },
    {
      'question': '18. For 18x² - 9y² = 36, what is the eccentricity?',
      'options': ['a. 5/3', 'b. 3/5', 'c. √3', 'd. 5/6'],
      'correctIndex': 2,
      'solution': 'Standard form: x²/2 - y²/4 = 1. a² = 2, b² = 4. c² = a² + b² = 6. Eccentricity e = c/a = √6/√2 = √3.',
      'image': null,
    },
    {
      'question': '19. Which equation could represent a comet\'s hyperbolic path?',
      'options': ['a. x² + y² = 1', 'b. y = x²', 'c. x²/9 - y²/16 = 1', 'd. x² + y²/4 = 1'],
      'correctIndex': 2,
      'solution': 'A hyperbola has the form x²/a² - y²/b² = 1 or y²/a² - x²/b² = 1. Only option c matches this form.',
      'image': null,
    },
    {
      'question': '20. Tower 150m tall with hyperbolic shape. Find width at narrowest point using x²/25 - y²/400 = 1.',
      'options': ['a. 15 meters', 'b. 10 meters', 'c. 4 meters', 'd. 17 meters'],
      'correctIndex': 1,
      'solution': 'Width at narrowest part = 2a. From a² = 25, we get a = 5. Therefore, width = 2(5) = 10 meters.',
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
      appBar: AppBar(title: Text('Hyperbola Geometry Quiz (${currentQuestionIndex + 1}/${questions.length})'), backgroundColor: Colors.purple, foregroundColor: Colors.white, actions: [Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text('Score: $score/${questions.length}', style: TextStyle(color: Colors.white))))]),
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
