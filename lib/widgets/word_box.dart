import 'package:flutter/material.dart';

class WordBox extends StatefulWidget {
  const WordBox({super.key, required this.correctCoords});

  final Set<Offset> correctCoords;

  @override
  State<WordBox> createState() => _WordBoxState();
}

class _WordBoxState extends State<WordBox> {
  List<List<String>> words = [
    ["L", "I", "O", "N"],
    ["", "O", "", ""],
    ["", "N", "O", "L"],
    ["", "", "", ""],
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         ...List.generate(words.length, (rowIndex) {
            final row = words[rowIndex];
            return Row(
              children: [
                 ...List.generate(row.length, (columnIndex) {
                   final column = row[columnIndex];
                   Offset currentOffset = Offset(columnIndex.toDouble(),rowIndex.toDouble());
                   bool isCorrect =  widget.correctCoords.contains(currentOffset);
                   return  Expanded(
                     child: Opacity(
                       opacity: column.isNotEmpty ? 1 : 0,
                       child: Container(
                         margin: const EdgeInsets.all(5),
                         height: 40,
                         decoration: BoxDecoration(
                             color: isCorrect ?Colors.red:Colors.transparent,
                             borderRadius: BorderRadius.circular(5),
                             border: Border.all(color: Colors.black)
                         ),
                         child: Center(
                           child: Text(
                             isCorrect ? column: "",
                             style: const TextStyle(
                                 color: Colors.black,
                                 fontWeight: FontWeight.w600,
                                 fontSize: 25),
                           ),
                         ),
                       ),
                     ),
                   );
                 })
              ],
            );
         })
      ],
    );
  }
}
