import 'dart:convert';
import 'dart:core';

import 'package:schoolapp/imports.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/quiz/quiz_model.dart';

class SubmittedQuiz extends StatefulWidget {
  String quizId;

  SubmittedQuiz(this.quizId);

  @override
  State<SubmittedQuiz> createState() => _SubmittedQuizState();
}

class _SubmittedQuizState extends State<SubmittedQuiz> {
  List<QuizModel> list = [];
  List<QuizModel> responseList = [];
  List<int> topList = [];
  int total = 0;
  int correct = 0;
  int incorrect = 0;
  int i = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getQuiz();
    });
  }

  getQuiz() async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        });
    var response = await http
        .get(Uri.parse(Constants.GET_QUIZ + "?quiz_id=" + widget.quizId));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var obj in data) {
        list.add(QuizModel("", "", "", "", "", obj['qus'], obj['opt1'],
            obj['opt2'], obj['opt3'], obj['opt4'], obj['ans'], "", ""));
        print(obj['ans']);
      }
      getSubmittedAnswer();
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  getSubmittedAnswer() async {
    var response = await http.get(
        Uri.parse(Constants.GET_SUBMITTED_ANSWER + "?quiz_id="+widget.quizId+"&std_no=123"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var obj in data) {
        responseList.add(QuizModel("", "", "", "", "", "", "", "", "", "", "",
            obj['response'].toString(), ""));
      }

      for (int i = 0; i < responseList.length; i++) {
        if (list[i].ans == responseList[i].response) {
          print("object");
          correct++;
        }
      }
      getTopResult();
    }
  }

  getTopResult() async {
    var response = await http
        .get(Uri.parse(Constants.GET_TOP_RESULT + "?quiz_id=" + widget.quizId));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      for(var obj in data){
        topList.add(obj['score']);
      }
      print(topList.length);
      setState(() {
        correct = correct;
        list = list;
        responseList = responseList;
        topList = topList;
      });
    }
  }

  getAnswer(int ans, int position) {
    if (ans == 1) {
      return list[position].opt1;
    } else if (ans == 2) {
      return list[position].opt2;
    } else if (ans == 3) {
      return list[position].opt3;
    } else if (ans == 4) {
      return list[position].opt4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstantsWidget.getBasicScreen(
        context,
        Column(
          children: [
            Container(
              height: 233,
              // margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 30, bottom: 10),
              decoration: BoxDecoration(
                  // color: Constants.mygrey,
                  // borderRadius: BorderRadius.circular(20)
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LeadBoard",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      positions(
                          60, Colors.black38, 80, 25, "Ankush Saini", topList.length>0 ? "${topList[0]}" : "0"),
                      positions(
                          90, Colors.amber, 110, 25, "Ankush Saini", topList.length>1 ? "${topList[1]}" : "0"),
                      positions(
                          60, Colors.brown, 80, 25, "Ankush Saini", topList.length>2 ? "${topList[2]}" : "0"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              width: double.infinity,
              height: 130,
              decoration: BoxDecoration(
                  color: Constants.myBluefaded,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Score",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        letterSpacing: 3,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      score("${responseList.length}", "Total", Colors.blue),
                      score("${correct}", "Correct", Colors.green),
                      score("${responseList.length - correct}", "Incorrect",
                          Colors.red),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 0.4,
              color: Colors.black.withOpacity(0.3),
            ),
            Expanded(
              child: ScrollConfiguration(
                behavior: ScrollBehavior().copyWith(overscroll: false),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, position) {
                      return Stack(
                        children: [
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 10, top: 10),
                                child: list[position].ans ==
                                        responseList[position].response
                                    ? Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.red,
                                      ),
                              )),
                          Container(
                            width: double.infinity,
                            // margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: list[position].ans ==
                                      responseList[position].response
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.1),
                              // borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Question ${position + 1}",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  list[position].qus,
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 12),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Answer",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  getAnswer(
                                      int.parse(list[position].ans), position),
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ));
  }

  Expanded score(String count, String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(30)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 12, fontFamily: "Poppins", color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column positions(double iconsize, Color color, double conWidth,
      double conHeight, String name, String score) {
    return Column(
      children: [
        Icon(
          Icons.emoji_events,
          size: iconsize,
          color: color,
        ),
        Container(
          width: conWidth,
          height: conHeight,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              name,
              style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
            ),
          ),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          score,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
