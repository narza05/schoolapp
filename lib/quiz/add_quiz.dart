import 'package:schoolapp/imports.dart';
import 'package:schoolapp/quiz/quiz_model.dart';
import 'package:schoolapp/quiz/review_quiz.dart';
import 'package:toast/toast.dart' as Toast;

class AddQuiz extends StatefulWidget {
  const AddQuiz({super.key});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  TextEditingController qus = TextEditingController();
  TextEditingController opt1 = TextEditingController();
  TextEditingController opt2 = TextEditingController();
  TextEditingController opt3 = TextEditingController();
  TextEditingController opt4 = TextEditingController();
  TextEditingController ans = TextEditingController();
  int radioValue = 1;
  List<QuizModel> list = [];

  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return ConstantsWidget.getBasicScreen(
        context,
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 65, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Question",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  ),
                  textfield(qus, "Write..."),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Options",
                    style: TextStyle(fontFamily: "Poppins", fontSize: 15),
                  ),
                  options(1, opt1, "Option 1"),
                  options(2, opt2, "Option 2"),
                  options(3, opt3, "Option 3"),
                  options(4, opt4, "Option 4"),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    bottomButton("Add Question", () {
                      list.add(QuizModel("","","","","",qus.text, opt1.text, opt2.text,
                          opt3.text, opt4.text, radioValue.toString(),"",""));
                      Toast.Toast.show("Added");
                    }),
                    SizedBox(
                      width: 10,
                    ),
                    bottomButton("Review", () async {
                      var result = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ReviewQuiz(list);
                      }));
                      setState(() {
                        list = result;
                      });
                    }),
                  ],
                ),
              ),
            ),
            ConstantsWidget.getBasicAppBar(
                Icon(Icons.arrow_back), "Create Quiz", null)
          ],
        ));
  }

  Expanded bottomButton(String title, Function() ontap) {
    return Expanded(
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          padding: EdgeInsets.all(10),
          height: 50,
          decoration: BoxDecoration(
              color: Constants.myBlue, borderRadius: BorderRadius.circular(15)),
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontFamily: "Poppins", color: Colors.white),
          )),
        ),
      ),
    );
  }

  Row options(int value, TextEditingController controller, String hint) {
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
        Expanded(child: textfield(controller, hint)),
      ],
    );
  }

  SizedBox textfield(TextEditingController controller, String hint) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        style: TextStyle(letterSpacing: 1, fontFamily: "Poppins", fontSize: 13),
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Constants.mygrey.withOpacity(0.6),
            contentPadding: EdgeInsets.only(left: 15, right: 35),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white.withOpacity(0))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white.withOpacity(0)))),
      ),
    );
  }
}
