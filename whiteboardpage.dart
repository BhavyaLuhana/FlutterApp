import 'package:flutter/material.dart';

void main() {
  runApp(const BoardApp());
}

class BoardApp extends StatelessWidget {
  const BoardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Board',
      home: const DrawingBoard(),
    );
  }
}

class DrawingBoard extends StatefulWidget {
  const DrawingBoard({super.key});

  @override
  _DrawingBoardState createState() => _DrawingBoardState();
}

class _DrawingBoardState extends State<DrawingBoard> {
  List<DrawnLine> _lines = [];
  Color _currentColor = Colors.black;
  double _currentBrushSize = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Board'),
      ),
      body: Column(
        children: [
          // Drawing area
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                setState(() {
                  _lines.add(DrawnLine(
                    points: [details.localPosition],
                    color: _currentColor,
                    brushSize: _currentBrushSize,
                  ));
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  _lines.last.points.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                setState(() {
                  _lines.last.points.add(Offset.zero); // Add a gap
                });
              },
              child: CustomPaint(
                painter: BoardPainter(_lines),
                size: Size.infinite,
              ),
            ),
          ),

          // Brush options
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey[200],
            child: Column(
              children: [
                // Brush size slider
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Brush Size:'),
                    Slider(
                      value: _currentBrushSize,
                      min: 1.0,
                      max: 20.0,
                      onChanged: (value) {
                        setState(() {
                          _currentBrushSize = value;
                        });
                      },
                    ),
                  ],
                ),

                // Color options - Horizontal scrolling
                const Text('Choose Color:'),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _currentColor = Colors.red;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.green),
                        onPressed: () {
                          setState(() {
                            _currentColor = Colors.green;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.blue),
                        onPressed: () {
                          setState(() {
                            _currentColor = Colors.blue;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            _currentColor = Colors.black;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.yellow),
                        onPressed: () {
                          setState(() {
                            _currentColor = Colors.yellow;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.purple),
                        onPressed: () {
                          setState(() {
                            _currentColor = Colors.purple;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.color_lens, color: Colors.orange),
                        onPressed: () {
                          setState(() {
                            _currentColor = Colors.orange;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  final List<DrawnLine> lines;
  BoardPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      final paint = Paint()
        ..color = line.color
        ..strokeCap = StrokeCap.round
        ..strokeWidth = line.brushSize;

      for (int i = 0; i < line.points.length - 1; i++) {
        if (line.points[i] != Offset.zero && line.points[i + 1] != Offset.zero) {
          canvas.drawLine(line.points[i], line.points[i + 1], paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class DrawnLine {
  List<Offset> points;
  final Color color;
  final double brushSize;

  DrawnLine({
    required this.points,
    required this.color,
    required this.brushSize,
  });
}