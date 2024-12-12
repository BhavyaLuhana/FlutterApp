import 'package:flutter/material.dart';

class SubjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SubjectIcon(
                    subjectName: 'Mathematics',
                    iconColor: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubjectDetailPage(
                            subjectName: 'Mathematics',
                            complexWord: 'Algebraic Structures',
                          ),
                        ),
                      );
                    },
                  ),
                  SubjectIcon(
                    subjectName: 'Biology',
                    iconColor: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubjectDetailPage(
                            subjectName: 'Biology',
                            complexWord: 'Cellular Respiration',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SubjectIcon(
                    subjectName: 'English',
                    iconColor: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubjectDetailPage(
                            subjectName: 'English',
                            complexWord: 'Lexicographical Order',
                          ),
                        ),
                      );
                    },
                  ),
                  SubjectIcon(
                    subjectName: 'Physics',
                    iconColor: Colors.purple,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubjectDetailPage(
                            subjectName: 'Physics',
                            complexWord: 'Quantum Entanglement',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SubjectIcon extends StatelessWidget {
  final String subjectName;
  final Color iconColor;
  final VoidCallback onTap;

  const SubjectIcon({
    required this.subjectName,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          MouseRegion(
            onEnter: (_) {},
            onExit: (_) {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 135,
              height: 135,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.book,
                color: iconColor,
                size: 75,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subjectName,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class SubjectDetailPage extends StatelessWidget {
  final String subjectName;
  final String complexWord;

  const SubjectDetailPage({required this.subjectName, required this.complexWord});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectName),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Top container with complex word
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[50],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Text(
                  complexWord,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              // Three doubled-size content containers
              Expanded(
                child: Column(
                  children: [
                    _buildContentRow(context, "assets/math.png", "Mathematics Concepts"),
                    const SizedBox(height: 20),
                    _buildContentRow(context, "assets/biology.png", "Biology Processes"),
                    const SizedBox(height: 20),
                    _buildContentRow(context, "assets/english.png", "Advanced Grammar"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentRow(BuildContext context, String imgPath, String subject) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 120, // 2x original height
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image Section
          SizedBox(
            height: 60,
            width: 60,
            child: Image.asset(imgPath, fit: BoxFit.cover),
          ),
          const SizedBox(width: 10),
          // Text Section
          Expanded(
            child: Text(
              subject,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SubjectScreen(),
  ));
}