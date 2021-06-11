import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/services/auth.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/views/create_quiz.dart';
import 'package:quiz_app/views/play_quiz.dart';
import 'package:quiz_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseService databaseService = new DatabaseService();
  Stream<QuerySnapshot>? quizStream;
  AuthService auth = new AuthService();
  Widget quizList() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: StreamBuilder<QuerySnapshot>(
            stream: quizStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return snapshot.data != null
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var user = snapshot.data!.docs[index].data();
                        print(" quiz gwt  $user");
                        return QuizTile(
                            imgUrl: (snapshot.data!.docs[index].data()
                                    as Map)['quizImgUrl']
                                .toString(),
                            desc: (snapshot.data!.docs[index].data()
                                    as Map)['quizDesc']
                                .toString(),
                            quizId: (snapshot.data!.docs[index].data()
                                    as Map)['quizId']
                                .toString(),
                            title: (snapshot.data!.docs[index].data()
                                    as Map)['quizTitle']
                                .toString());
                      })
                  : Center(
                      child: Container(
                        child: CircularProgressIndicator(),
                      ),
                    );
            }));
  }

  @override
  void initState() {
    print("papapapapapapappa");
    databaseService.getQuizData().then((data) => {
          setState(() {
            quizStream = data;
          })
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
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.blue,
              ),
              onPressed: () {
                auth.signOut().then((value) => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MyApp())));
                // do something});
              },
            )
          ],
        ),
        body: Container(child: quizList()),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          },
        ));
  }
}

class QuizTile extends StatelessWidget {
  late final String imgUrl;
  late final String title;
  late final String desc;
  late final String quizId;
  QuizTile(
      {required this.imgUrl,
      required this.title,
      required this.desc,
      required this.quizId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayQuiz(
                      quizId: quizId,
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 8),
          height: 150,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imgUrl,
                    width: MediaQuery.of(context).size.width - 48,
                    fit: BoxFit.cover),
              ),
              Container(
                  // color: Colors.black,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w500)),
                      Text(desc,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400))
                    ],
                  ))
            ],
          )),
    );
  }
}
