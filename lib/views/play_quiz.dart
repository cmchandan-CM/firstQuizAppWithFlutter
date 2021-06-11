import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/questionModel.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/result.dart';
import 'package:quiz_app/widgets/quiz_play_widgets.dart';
import 'package:quiz_app/widgets/widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  PlayQuiz({required this.quizId});

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttempted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  QuerySnapshot? dat;
  DatabaseService databaseService = new DatabaseService();

  QuestionModel getQuestionModelFromDatasnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = (questionSnapshot.data() as Map)["question"];
    List<String> options = [
      (questionSnapshot.data() as Map)["option1"],
      (questionSnapshot.data() as Map)["option2"],
      (questionSnapshot.data() as Map)["option3"],
      (questionSnapshot.data() as Map)["option4"]
    ];
    options.shuffle();
    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = (questionSnapshot.data() as Map)["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("quizid in play quiz   ${widget.quizId}");
    databaseService.getQuizQna(widget.quizId).then((value) {
      dat = value;
      print((dat!.docs[0].data() as Map));
      _notAttempted = 0;
      _correct = 0;
      _incorrect = 0;
      total = dat!.docs.length;

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      // resizeToAvoidBottomPadding: false,
      body: Container(
          child: Column(
        children: [
          dat != null
              ? Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: dat!.docs.length,
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                            questionModel: getQuestionModelFromDatasnapshot(
                                dat!.docs[index]),
                            index: index);
                      }),
                )
              : Container()
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Results(
                      correct: _correct, incorrect: _incorrect, total: total)));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final int index;
  final QuestionModel questionModel;
  QuizPlayTile({required this.questionModel, required this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Q${widget.index + 1} ${widget.questionModel.question}",
              style: TextStyle(fontSize: 18, color: Colors.black87)),
          SizedBox(height: 12),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "A",
                description: widget.questionModel.option1,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "B",
                description: widget.questionModel.option2,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "C",
                description: widget.questionModel.option3,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttempted = _notAttempted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
                option: "D",
                description: widget.questionModel.option4,
                correctAnswer: widget.questionModel.correctOption,
                optionSelected: optionSelected),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
