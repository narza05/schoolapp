import 'package:flutter/services.dart';
import 'package:schoolapp/constants.dart';
import 'package:schoolapp/constants_widget.dart';
import 'package:schoolapp/imports.dart';
import 'package:schoolapp/live/live.dart';
import 'package:schoolapp/notes/all_notes.dart';
import 'package:schoolapp/quiz/all_quiz.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    ConstantsWidget.getStatusBar(Constants.myBlue, Brightness.light);
    return ConstantsWidget.getNavigationScreen(
        context,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Constants.myBlue,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage("assets/schoolcover.jpg"),
                        ),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      flex: 5,
                      child: Text(
                        "School Name",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      )),
                ],
              ),
            ),
            Container(
              height: 90,
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: Constants.myBluefaded,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/profile.jpg"),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Ankush",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                      Text(
                        "1002AE5",
                        style: TextStyle(fontSize: 11, fontFamily: "Poppins"),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 8),
                    )
                  ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: AssetImage("assets/banner.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  feature(Icons.menu_book_outlined, "Notes", Color(0xff4dadd9),
                      () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AllNotes();
                    }));
                  }),
                  feature(Icons.quiz_outlined, "Quiz", Color(0xffe39035), () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return AllQuiz();
                        }));
                  }),
                  feature(Icons.my_library_books_outlined, "Courses",
                      Color(0xffdc0c35), null),
                ],
              ),
            ),
          ],
        ));
  }

  Widget feature(IconData icon, String title, Color color, Function()? ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 100,
        width: Constants.getScreenWidth(context) / 3 - 15,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 30,
                  )),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 11),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
