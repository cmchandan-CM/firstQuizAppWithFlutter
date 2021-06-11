import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizid;
  AddQuestion({required this.quizid});

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String question, option1, option2, option3, option4;
  uploadQuestionData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };
      await databaseService
          .addQuestionData(questionMap, widget.quizid)
          .then((value) => {
                setState(() {
                  _isLoading = false;
                })
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter Question" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Question",
                          ),
                          onChanged: (val) => {question = val}),
                      SizedBox(height: 12),
                      TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter option 1" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Option 1 (Correct Answer)",
                          ),
                          onChanged: (val) => {option1 = val}),
                      SizedBox(height: 12),
                      TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter option 2" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Option 2",
                          ),
                          onChanged: (val) => {option2 = val}),
                      TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter option 3" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Option 3",
                          ),
                          onChanged: (val) => {option3 = val}),
                      TextFormField(
                          validator: (val) {
                            return val!.isEmpty ? "Enter option 4" : null;
                          },
                          decoration: InputDecoration(
                            hintText: "Option 4",
                          ),
                          onChanged: (val) => {option4 = val}),
                      Spacer(),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                // createQuizOnline();
                              },
                              child: blueButton(
                                  context: context,
                                  label: "Submit",
                                  buttonWidth:
                                      MediaQuery.of(context).size.width / 2 -
                                          36)),
                          SizedBox(width: 24),
                          GestureDetector(
                              onTap: () {
                                // createQuizOnline();
                                uploadQuestionData();
                              },
                              child: blueButton(
                                  context: context,
                                  label: "Add Question",
                                  buttonWidth:
                                      MediaQuery.of(context).size.width / 2 -
                                          36)),
                        ],
                      ),
                      SizedBox(height: 12)
                    ],
                  )),
            ),
    );
  }
}
