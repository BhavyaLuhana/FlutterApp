import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int selectedOption = -1;
  bool isAnswered = false;
  int score = 0;
  int hoveredOption = -1;

  final List<Map<String, dynamic>> questions = [
    {
      'image': 'assets/images/apple_sign.jpg',
      'options': ['Apple', 'Orange', 'Banana', 'Grapes'],
      'correctOption': 0,
    },
    {
      'image': 'assets/images/orange_sign.jpg',
      'options': ['Apple', 'Orange', 'Banana', 'Grapes'],
      'correctOption': 1,
    },
    {
      'image': 'assets/images/banana_sign.jpg',
      'options': ['Apple', 'Orange', 'Banana', 'Grapes'],
      'correctOption': 2,
    },
    {
      'image': 'assets/images/grapes_sign.jpg',
      'options': ['Apple', 'Orange', 'Banana', 'Grapes'],
      'correctOption': 3,
    },
  ];

  void checkAnswer(int index) {
    setState(() {
      selectedOption = index;
      isAnswered = true;
      if (index == questions[currentQuestionIndex]['correctOption']) {
        score++;
      }
      Future.delayed(Duration(seconds: 1), () {
        nextQuestion();
      });
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOption = -1;
        isAnswered = false;
        hoveredOption = -1;
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Quiz Completed'),
            content: Text('You scored $score/${questions.length}!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  restartQuiz();
                },
                child: Text('Restart'),
              ),
            ],
          ),
        );
      }
    });
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedOption = -1;
      isAnswered = false;
      score = 0;
      hoveredOption = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    final List<String> options = currentQuestion['options'];
    final int correctOption = currentQuestion['correctOption'];

    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Light aesthetic background color
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent.shade200,
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  height: 10,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor:
                  (currentQuestionIndex + 1) / questions.length.toDouble(),
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 48.0),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8.0,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}: Which sign is this?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade100, Colors.purple.shade300],
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.asset(
              currentQuestion['image'],
              height: 200,
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: options.asMap().entries.map((entry) {
              int index = entry.key;
              String text = entry.value;

              Color? color;
              if (isAnswered) {
                if (index == correctOption) {
                  color = Colors.green.shade200;
                } else if (index == selectedOption) {
                  color = Colors.red.shade200;
                }
              } else if (hoveredOption == index) {
                color = Colors.green.shade100;
              }

              return MouseRegion(
                onEnter: (_) {
                  if (!isAnswered) {
                    setState(() {
                      hoveredOption = index;
                    });
                  }
                },
                onExit: (_) {
                  if (!isAnswered) {
                    setState(() {
                      hoveredOption = -1;
                    });
                  }
                },
                child: GestureDetector(
                  onTap: isAnswered ? null : () => checkAnswer(index),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 12.0),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: color ?? Colors.purple.shade100,
                      border: Border.all(
                        color: Colors.deepPurple.shade400,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.shade100,
                          blurRadius: 8.0,
                          offset: Offset(2, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple.shade900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: QuizPage(),
));
