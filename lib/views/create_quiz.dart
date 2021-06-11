import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/add_question.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  DatabaseService databaseService = new DatabaseService();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String quizImageUrl, quizTitle, quizDescription, quizId;
  createQuizOnline() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizId,
        "quizImgUrl": quizImageUrl,
        "quizTitle": quizTitle,
        "quizDesc": quizDescription
      };
      await databaseService.addQuizData(quizMap, quizId).then((value) => {
            setState(() {
              _isLoading = false;
            }),
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AddQuestion(quizid: quizId)))
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
          iconTheme: IconThemeData(color: Colors.black87),
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
                              return val!.isEmpty
                                  ? "Enter Quiz Image Url"
                                  : null;
                            },
                            decoration: InputDecoration(
                              hintText: "Quiz Image Url (Optional)",
                            ),
                            onChanged: (val) => {quizImageUrl = val}),
                        SizedBox(height: 12),
                        TextFormField(
                            validator: (val) {
                              return val!.isEmpty ? "Enter Quiz Title" : null;
                            },
                            decoration: InputDecoration(
                              hintText: "Quiz Title",
                            ),
                            onChanged: (val) => {quizTitle = val}),
                        SizedBox(height: 12),
                        TextFormField(
                            validator: (val) {
                              return val!.isEmpty
                                  ? "Enter Quiz Description"
                                  : null;
                            },
                            decoration: InputDecoration(
                              hintText: "Quiz Description",
                            ),
                            onChanged: (val) => {quizDescription = val}),
                        Spacer(),
                        GestureDetector(
                            onTap: () {
                              createQuizOnline();
                            },
                            child: blueButton(
                                context: context, label: "Create Quiz")),
                        SizedBox(height: 12)
                      ],
                    )),
              ));
  }
}
