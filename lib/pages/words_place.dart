import 'package:flutter/material.dart';
import 'package:words_place_in_box/widgets/circle_container.dart';
import 'package:words_place_in_box/widgets/word_box.dart';
import 'package:collection/collection.dart';

class WordPlace extends StatefulWidget {
  const WordPlace({super.key});

  @override
  State<WordPlace> createState() => _WordPlaceState();
}

class _WordPlaceState extends State<WordPlace> {
  Set<Offset> correctWord = {};
  List<String> guessWord = [];
  List<Map<String, dynamic>> winWords = [
    {
      'coords': [Offset(0, 0), Offset(1, 0), Offset(2, 0), Offset(3, 0)],
      'words': ['L', 'I', 'O', 'N']
    },
    {
      'coords': [Offset(1, 0), Offset(1, 1), Offset(1, 2)],
      'words': ['I', 'O', 'N']
    },
    {
      'coords': [Offset(1, 2), Offset(2, 2), Offset(3, 2)],
      'words': ['N', 'O', 'L']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WordBox(
            correctCoords: correctWord,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              guessWord.join(),
              style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: isWinWord(guessWord) ? Colors.green: Colors.black),
            ),
          ),
          WordCircle(
            onDrawEnd: (List<String> word) {
              guessWord = word;
              final matchedMap = winWords.firstWhereOrNull(
                  (element)  {
                    print(">>> ${element['words'].join() } == $word");
                    return element['words'].join() == word.join();
                  });
              if (matchedMap != null) {
                (matchedMap!['coords'] as List).forEach((element) {
                  print(">>> offset -> $element}");
                  correctWord.add(element);
                })
             ;
                print(">>>after added - $correctWord");
              } else {
                print("Wordd==>$correctWord");
              }
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
  bool isWinWord(List<String> words){
    final matchedMap = winWords.firstWhereOrNull(
            (element)  {
          return element['words'].join() == words.join();
        });

    return matchedMap != null;
  }
}

