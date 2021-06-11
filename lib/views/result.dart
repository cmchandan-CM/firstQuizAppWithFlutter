import 'package:flutter/material.dart';
import 'package:quiz_app/widgets/widgets.dart';

class Results extends StatefulWidget {
  final int correct, incorrect, total;
  Results(
      {required this.correct, required this.incorrect, required this.total});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
          Text("${widget.correct}/${widget.total}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Text(
            "You answered ${widget.correct} answers correctly"
            " and ${widget.incorrect} answers incorrectly",
            style: TextStyle(fontSize: 17, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 14),
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: blueButton(context: context, label: "Go to Home"))
        ]))));
  }
}
