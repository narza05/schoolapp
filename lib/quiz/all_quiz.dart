import 'package:schoolapp/imports.dart';
import 'package:schoolapp/quiz/add_quiz.dart';

class AllQuiz extends StatefulWidget {
  const AllQuiz({super.key});

  @override
  State<AllQuiz> createState() => _AllQuizState();
}

class _AllQuizState extends State<AllQuiz> {
  bool scrolled = false;
  var contoller = ScrollController();


  @override
  void initState() {
    super.initState();
    contoller.addListener(() {
      if(contoller.position.pixels == contoller.position.maxScrollExtent){
        if(scrolled==false){
          setState(() {
            scrolled = true;
          });
        }
      }else{
        if(scrolled==true && contoller.position.pixels < contoller.position.maxScrollExtent){
          setState(() {
            scrolled = false;
          });
        }
      }
    });
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
                          itemCount: 15,
                          itemBuilder: (context, position) {
                            return Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 20),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              decoration: BoxDecoration(
                                  color: Constants.mygrey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "Quiz Name",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "Biology",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Constants.myBlue,
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                      child: Center(
                                          child: Text(
                                        "Start",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins",
                                            fontSize: 11),
                                      )),
                                    ),
                                  )
                                ],
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
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
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
