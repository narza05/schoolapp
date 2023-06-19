import 'dart:convert';

import 'package:schoolapp/imports.dart';
import 'package:schoolapp/quiz/add_quiz.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/quiz/quiz.dart';
import 'package:schoolapp/quiz/quiz_model.dart';
import 'package:schoolapp/quiz/submitted_quiz.dart';

class AllQuiz extends StatefulWidget {
  const AllQuiz({super.key});

  @override
  State<AllQuiz> createState() => _AllQuizState();
}

class _AllQuizState extends State<AllQuiz> {
  bool scrolled = false;
  var contoller = ScrollController();
  List<QuizModel> list = [];
  List<QuizModel> submittedList = [];

  @override
  void initState() {
    super.initState();
    listListener();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // getAllQuiz();
      getSubmittedQuiz();
    });
  }

  listListener() {
    contoller.addListener(() {
      if (contoller.position.pixels == contoller.position.maxScrollExtent) {
        if (scrolled == false) {
          setState(() {
            scrolled = true;
          });
        }
      } else {
        if (scrolled == true &&
            contoller.position.pixels < contoller.position.maxScrollExtent) {
          setState(() {
            scrolled = false;
          });
        }
      }
    });
  }

  getSubmittedQuiz() async {
    var response =
        await http.get(Uri.parse(Constants.GET_SUBMITTED_QUIZ + "?std_no=123"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var obj in data) {
        submittedList.add(QuizModel("", obj['date'], obj['quiz_id'].toString(), obj['title'], obj['subject'],
            "", "", "", "", "", "", "", "true"));
        print(obj['quiz_id']);
      }
      getAllQuiz();
    }
  }

  getAllQuiz() async {
    var response = await http.get(Uri.parse(Constants.GET_ALLQUIZ));
    if (response.statusCode == 200) {
      list.clear();
      var data = jsonDecode(response.body);
      for (var obj in data) {
        list.add(QuizModel("", obj['date'], obj['id'].toString(), obj['title'],
            obj['subject'], "", "", "", "", "", "", "", ""));
      }

      for (int a = 0; a < submittedList.length; a++) {
        for (int b = 0; b < list.length; b++) {
          if (submittedList[a].quizId.contains(list[b].quizId)) {
            // list.add(QuizModel(
            //     "",
            //     list[a].date,
            //     list[a].quizId.toString(),
            //     list[a].title,
            //     list[a].subject,
            //     "",
            //     "",
            //     "",
            //     "",
            //     "",
            //     "",
            //     "",
            //     "true"));
            list.removeAt(b);
            break;
          } else {
            continue;
          }
        }
      }
      for (var obj in submittedList) {
        list.add(obj);
      }
      setState(() {
        list = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConstantsWidget.getBasicScreen(
        context,
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 55),
              child: Column(
                children: [
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: ScrollBehavior().copyWith(overscroll: false),
                      child: ListView.builder(
                          controller: contoller,
                          itemCount: list.length,
                          itemBuilder: (context, position) {
                            return GestureDetector(
                              onTap:
                                  list[position].isSubmitted == ""
                                      ?
                                  //     () async {
                                  //         final bool? refresh =
                                  //             await Navigator.push(context,
                                  //                 MaterialPageRoute(
                                  //                     builder: (context) {
                                  //           return Quiz(list[position].quizId);
                                  //         }));
                                  //         if (refresh == true) {
                                  //           getAllQuiz();
                                  //         }
                                  //       },

                                  () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Quiz(list[position].quizId,list[position].date,list[position].title,list[position].subject);
                                })).then((value) => getAllQuiz());
                              }
                              : () {
                                  print(list[position].quizId);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SubmittedQuiz(list[position].quizId);
                                  }));
                                },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, top: 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                    color: Constants.mygrey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            list[position].title,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            list[position].subject,
                                            style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 12,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                            color: Constants.myBlue,
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        child: Center(
                                            child: Text(
                                          list[position].isSubmitted == ""
                                              ? "Start"
                                              : "Review",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 11),
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                margin: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                height: scrolled ? 0 : 40,
                duration: Duration(milliseconds: 200),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddQuiz();
                    }));
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Constants.myBlue,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Text(
                      "Add Quiz",
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),
            ConstantsWidget.getBasicAppBar(
                Icon(Icons.arrow_back), "Quiz", null),
          ],
        ));
  }
}
