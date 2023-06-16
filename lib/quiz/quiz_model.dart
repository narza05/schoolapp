import 'package:schoolapp/quiz/quiz.dart';

class QuizModel{
  String stdNo = "";
  String date = "";
  String quizId = "";
  String title = "";
  String subject = "";
  String qus = "";
  String opt4 = "";
  String opt3 = "";
  String opt2 = "";
  String opt1 = "";
  String ans = "";
  String response = "";
  String isSubmitted = "";

  QuizModel(this.stdNo,this.date,this.quizId,this.title,this.subject,this.qus, this.opt1, this.opt2, this.opt3, this.opt4, this.ans, this.response, this.isSubmitted);

}