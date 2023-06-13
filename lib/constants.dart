import 'package:schoolapp/imports.dart';
import 'package:intl/intl.dart';



class Constants{
  static final String ROOT = "http://192.168.0.186/schoolapp/";
  static final String ADD_CONFERENCE = ROOT + "conference/addConference.php";
  static final String GET_CONFERENCE = ROOT + "conference/getConference.php";
  static final String ADD_NOTES = ROOT + "notes/addNotes.php";
  static final String GET_NOTES = ROOT + "notes/getNotes.php";
  static final String ADD_QUIZ = ROOT + "quiz/addQuiz.php";


  static final Color backgroundgrey = Color(0xfff8f8f8);
  static final Color mygrey = Color(0xffdbdbdb);
  static final Color myBlue = Color(0xff0052bc);
  static final Color myBluefaded = Color(0xffdff0fa);
  static final Color myRedFaded = Color(0xffefbbbc);
  static final Color myYellowFaded = Color(0xfff9e076);

  static double getScreenHeight(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    final mq = height - padding.top - padding.bottom;
    return mq;
  }
  static double getScreenWidth(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
     return width;
  }

  static getCurrentDate(){
    return DateFormat("yyyy-MM-dd").format(DateTime.now());
  }
  static getCurrentTime(){
    return DateFormat("HH:mm").format(DateTime.now());
  }
}