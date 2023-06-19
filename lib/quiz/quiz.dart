import 'dart:convert';
import 'package:toast/toast.dart' as Toast;
import 'package:schoolapp/imports.dart';
import 'package:schoolapp/quiz/quiz_model.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:http/http.dart' as http;

import '../navigation.dart';

class Quiz extends StatefulWidget {
  String quizId;
  String date;
  String title;
  String subject;

  Quiz(this.quizId, this.date, this.title, this.subject);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<QuizModel> qusList = [];
  List<QuizModel> responseList = [];
  int index = 0;
  int radioValue = 1;
  bool isStart = false;
  bool isFinished = false;


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getQuiz();
    });
    super.initState();
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
        qusList.add(QuizModel("", "", "", "", "", obj['qus'], obj['opt1'],
            obj['opt2'], obj['opt3'], obj['opt4'], obj['ans'], "", ""));
        print(obj['qus']);
      }
      setState(() {
        qusList = qusList;
        isStart = true;
      });
    }
    Navigator.of(context, rootNavigator: true).pop();
  }

  submitQuiz() async {
    for(int i=0; i<responseList.length; i++){
      var response = await http.post(Uri.parse(Constants.SUBMIT_QUIZ), body: {
        "std_no" : "123",
        "date" : widget.date,
        "quiz_id" : widget.quizId,
        "title" : widget.title,
        "subject" : widget.subject,
        "qus" : responseList[i].qus,
        "response" : responseList[i].response,
        "ans" : responseList[i].ans
      });
      if(i==responseList.length-1){
        if(response.statusCode==200 && response.body == "1"){
          addResult();
        }
      }
    }
  }

  addResult() async {
    var response = await http.get(Uri.parse(Constants.ADD_RESULT+"?std_no=123&quiz_id="+widget.quizId));
    if(response.statusCode==200){
      if(response.body.contains("1")){
        Toast.Toast.show("Submitted");
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
          return Navigation();
        }), (route) => false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return ConstantsWidget.getBasicScreen(
        context,
        Stack(
          children: [
            Column(
              children: [
                Container(
                  height: Constants.getScreenHeight(context) / 3,
                  padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                  decoration: BoxDecoration(
                      color: Constants.backgroundgrey,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(15))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.arrow_back),
                          // isStart == true
                          //     ? SlideCountdown(
                          //         duration: Duration(minutes: 2),
                          //       )
                          //     : Container(
                          //         height: 0,
                          //       ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 120,
                        child: ScrollConfiguration(
                          behavior:
                              ScrollBehavior().copyWith(overscroll: false),
                          child: SingleChildScrollView(
                            child: Text(
                              isStart == true ? qusList[index].qus : "No data",
                              style: TextStyle(
                                  letterSpacing: 0.6,
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Question ${index + 1} of ${qusList.length}",
                            style:
                                TextStyle(fontSize: 11, fontFamily: "Poppins"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: Constants.getScreenHeight(context) / 1.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          options(
                            1,
                            isStart == true ? qusList[index].opt1 : "No data",
                          ),
                          options(
                            2,
                            isStart == true ? qusList[index].opt2 : "No data",
                          ),
                          options(
                            3,
                            isStart == true ? qusList[index].opt3 : "No data",
                          ),
                          options(
                            4,
                            isStart == true ? qusList[index].opt4 : "No data",
                          ),
                          GestureDetector(
                            onTap: isFinished == false ? () {
                              responseList.add(QuizModel(
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  (index + 1).toString(),
                                  "",
                                  "",
                                  "",
                                  "",
                                  qusList[index].ans,
                                  radioValue.toString(), ""));
                              setState(() {
                                if (index < qusList.length - 1) {
                                  index = index + 1;
                                }
                                if (index == qusList.length - 1) {
                                  isFinished = true;
                                }
                              });
                            } : (){
                              responseList.add(QuizModel(
                                  "",
                                  "",
                                  "",
                                  "",
                                  "",
                                  (index + 1).toString(),
                                  "",
                                  "",
                                  "",
                                  "",
                                  qusList[index].ans,
                                  radioValue.toString(), ""));
                              submitQuiz();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 10),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Constants.myBlue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Center(
                                  child: Text(
                                isFinished == true ? "Finished" : "Next",
                                style: TextStyle(
                                    fontFamily: "Poppins", color: Colors.white),
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  Row options(int value, String text) {
    return Row(
      children: [
        Radio(
            value: value,
            groupValue: radioValue,
            onChanged: (value) {
              setState(() {
                radioValue = value!;
              });
            }),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 5, right: 15),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Constants.mygrey),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: 13, letterSpacing: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
