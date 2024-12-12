import 'package:flutter/material.dart';
import 'quizpage.dart';
import 'searchpage.dart';
import 'subjectpage.dart';
import 'whiteboardpage.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/9295150.jpg', height: 30),
          ),
        ],
      ),
      body: Center(
        child: Image.asset(
          'assets/images/sttimg.jpg',
          height: 200,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_sharp),
            label: 'Notepad',
          ),
        ],
        onTap: (int index) {
          switch (index) {
            case 0:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('You are already on the Home Page')),
              );
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => WordSearchScreen()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => QuizPage()));
              break;
            case 3:
              Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectScreen()));
              break;
            case 4:
              Navigator.push(context, MaterialPageRoute(builder: (context) => BoardApp()));
              break;
          }
        },
      ),
    );
  }
}
