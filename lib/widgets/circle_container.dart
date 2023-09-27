import 'dart:developer';

import 'package:flutter/material.dart';

class WordCircle extends StatefulWidget {
  const WordCircle({super.key, required this.onDrawEnd});

  final Function(List<String> wordList) onDrawEnd;

  @override
  State<WordCircle> createState() => WordCircleState();
}

class WordCircleState extends State<WordCircle> {
  Map<String, Rect> wordList = {};

  Map<String, Rect> wordContstraints = {
    "L": const Rect.fromLTWH(100, 10, 90, 90),
    "I": const Rect.fromLTWH(10, 100, 90, 90),
    "O": const Rect.fromLTWH(210,90, 90, 90),
    "N": const Rect.fromLTWH(110, 210, 90, 90),

  };
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(300),
      child: GestureDetector(
        onPanStart: (d) => wordList.clear(),
        onPanEnd: (d) {
          final cut = wordList.keys.toSet().toList().map((e) => e.length > 1 ? e.substring(1) : e);
          widget.onDrawEnd(cut.toList());
          wordList.clear();
          setState(() {});
        },
        onPanUpdate: (detail) {
          final touch = detail.localPosition;
          wordContstraints.entries.forEach((entry) {
            if (entry.value.contains(touch)) {
              wordList.putIfAbsent(entry.key, () => entry.value);
            }
          });
          setState(() {});
        },
        child: Container(
          color: Colors.black54,

          width: 300,
          height: 300,
          child: Stack(
            children: [
              ...wordContstraints.keys.map(
                    (key) => Positioned(
                  top: wordContstraints[key]!.top,
                  left: wordContstraints[key]!.left,
                  child: SizedBox(
                    // color: Colors.red,
                    width: wordContstraints[key]!.width,
                    height: wordContstraints[key]!.height,

                    child: Center(
                      child: Text(
                        key.length > 1 ? key.substring(1) : key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 300,
                height: 300,
                child: CustomPaint(
                  painter: LinesPainter(linesData: wordList),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinesPainter extends CustomPainter {
  final Map<String, Rect> linesData;
  const LinesPainter({required this.linesData});

  @override
  void paint(Canvas canvas, Size size) {
    final pen = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    log('rebuild ; ${linesData}');

    linesData.keys.forEach((key) {
      final currentIndex = linesData.keys.toList().indexOf(key);
      if (currentIndex == linesData.keys.length - 1) return;
      canvas.drawLine(linesData[key]!.center, linesData[linesData.keys.toList()[1 + currentIndex]]!.center, pen);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}