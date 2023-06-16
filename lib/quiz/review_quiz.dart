import 'dart:convert';
import 'dart:math';
import 'package:schoolapp/imports.dart';
import 'package:schoolapp/quiz/quiz_model.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:toast/toast.dart' as Toast;

class ReviewQuiz extends StatefulWidget {
  List<QuizModel> list = [];

  ReviewQuiz(this.list);

  @override
  State<ReviewQuiz> createState() => _ReviewQuizState();
}

class _ReviewQuizState extends State<ReviewQuiz> {
  TextEditingController title = TextEditingController();
  TextEditingController subject = TextEditingController();
  bool selected = false;
  var controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      listListener();
    });
  }

  listListener() {
    if (selected == false &&
        controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() {
        selected = true;
      });
    } else {
      if (selected == true &&
          controller.position.pixels < controller.position.maxScrollExtent) {
        setState(() {
          selected = false;
        });
      }
    }
  }

  quizExists(int quizId)async{
    var response = await http.get(Uri.parse(Constants.QUIZ_EXISTS+"?quiz_id=$quizId"));
    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data['msg'] == "1"){
        for (var obj in widget.list) {
          addQuiz(quizId,
              obj.qus, obj.opt1, obj.opt2, obj.opt3,
              obj.opt4, obj.ans);
        }
      }else{
        Toast.Toast.show("Try again");
      }
    }
  }

  addQuiz(int quizId, String qus, String opt1, String opt2, String opt3, String opt4, String ans)async{
    print(1);
    var response = await http.post(Uri.parse(Constants.ADD_QUIZ), body: {
      "date" : Constants.getCurrentDate(),
      "quiz_id" : quizId.toString(),
      "title" : title.text,
      "subject" : subject.text,
      "qus" : qus,
      "opt1" : opt1,
      "opt2" : opt2,
      "opt3" : opt3,
      "opt4" : opt4,
      "ans" : ans
    });

    if(response.statusCode==200){
      var data = jsonDecode(response.body);
      if(data['msg'] == "1"){
        Toast.Toast.show("Quiz Added");
        title.clear();
        subject.clear();
        widget.list.clear();
        var nav = Navigator.of(context);
        nav.pop();
        nav.pop();
      }
    }else{
      Toast.Toast.show("Error");
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return WillPopScope(
        child: ConstantsWidget.getBasicScreen(
            context,
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 55, left: 0, right: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollBehavior().copyWith(overscroll: false),
                          child: ListView.builder(
                              controller: controller,
                              itemCount: widget.list.length,
                              itemBuilder: (context, position) {
                                return Container(
                                  color: position % 2 == 0
                                      ? Constants.myBluefaded.withOpacity(0.6)
                                      : Constants.myYellowFaded.withOpacity(0.5),
                                  padding: EdgeInsets.only(
                                      top: 15, bottom: 15, left: 10, right: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Question: ${position + 1}",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      textContainer(Colors.white,
                                          widget.list[position].qus),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Options",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      textContainer(Colors.white,
                                          widget.list[position].opt1),
                                      textContainer(Colors.white,
                                          widget.list[position].opt2),
                                      textContainer(Colors.white,
                                          widget.list[position].opt3),
                                      textContainer(Colors.white,
                                          widget.list[position].opt4),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
                AnimatedPositioned(
                  height: MediaQuery.of(context).size.height,
                  duration: Duration(milliseconds: 300),
                  bottom: selected ? -190 : 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: Colors.transparent,
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal:10, vertical: 0),
                        margin:
                            EdgeInsets.only(left: 10, right: 10, bottom: 0),
                        decoration: BoxDecoration(
                            color: Constants.mygrey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textfield(title, "Title..."),
                            textfield(subject, "Subject..."),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if(widget.list.isNotEmpty && title.text.isNotEmpty && subject.text.isNotEmpty) {
                                    Random random = new Random();
                                    int quizId = random.nextInt(10000);
                                    quizExists(quizId);
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Constants.myBlue,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                    child: Text(
                                  "Create",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white),
                                )),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pop(context, widget.list);
                    setState(() {
                      Navigator.pop(context, "widget.list");
                    });
                  },
                  child: ConstantsWidget.getBasicAppBar(
                      Icon(Icons.arrow_back), "Review Quiz", null),
                )
              ],
            )),
        onWillPop: () {
          Navigator.pop(context, "widget.list");
          return new Future(() => false);
        });
  }

  Container textContainer(Color color, String text) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      padding: EdgeInsets.all(10),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(15), color: color),
      child: Center(
          child: Text(
        text,
        style: TextStyle(fontFamily: "Poppins"),
      )),
    );
  }

  SizedBox textfield(TextEditingController controller, String hint) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        style: TextStyle(letterSpacing: 1, fontFamily: "Poppins", fontSize: 13),
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white.withOpacity(0))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white.withOpacity(0)))),
      ),
    );
  }
}
