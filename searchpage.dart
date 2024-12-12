import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Search Dictionary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WordSearchScreen(),
    );
  }
}

class WordSearchScreen extends StatefulWidget {
  @override
  _WordSearchScreenState createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  String searchText = "";
  String imageUrl = "";
  String descriptionText = "";

  void searchWordInDictionary(String word) {
    setState(() {
      if (word.toLowerCase() == "nice") {
        imageUrl = "assets/images/giphy.gif"; // Path to the "nice" GIF
        descriptionText = "Like a nice clean surface that is smooth.";
      }
      else {
        imageUrl = "";
        descriptionText = "Word not found in the dictionary.";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Search Dictionary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                searchText = value;
              },
              decoration: InputDecoration(
                labelText: 'Enter a word',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => searchWordInDictionary(searchText),
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            if (imageUrl.isNotEmpty)
              Image.asset(
                imageUrl,
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 10),
            Text(
              descriptionText,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
