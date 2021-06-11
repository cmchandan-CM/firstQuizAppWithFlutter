import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseService {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addQuestionData(
      Map<String, dynamic> questionData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizId)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizData() async {
    return FirebaseFirestore.instance.collection('quiz').snapshots();
  }

  getQuizQna(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("quiz")
        .doc(quizId)
        .collection("QNA")
        .get();
  }
}
