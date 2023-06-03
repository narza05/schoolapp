import 'package:schoolapp/constants.dart';
import 'package:schoolapp/constants_widget.dart';
import 'package:schoolapp/imports.dart';
import 'package:schoolapp/live/live.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstantsWidget.getAppBar(CircleAvatar(
            radius: 18,
            backgroundImage: AssetImage("assets/schoolcover.jpg"),
          ),  "School Name", null),
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
                      "Class 1-A",
                      style: TextStyle(fontSize: 11, fontFamily: "Poppins"),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 150,
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    feature(
                        Icons.menu_book_rounded, "Notes", Color(0xff000365),null),
                    SizedBox(
                      height: 10,
                    ),
                    feature(Icons.quiz_outlined, "Quiz", Color(0xffe39035),null),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    feature(Icons.brightness_auto_outlined, "Performance",
                        Colors.red,null),
                    SizedBox(
                      height: 10,
                    ),
                    feature(Icons.assignment, "Exam", Color(0xff4dadd9),null),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    feature(Icons.live_tv_rounded, "Live", Color(0xff993366),(){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return VideoConferencePage(conferenceID: "test1234test");
                      }));
                    }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget feature(IconData icon, String title, Color color, Function()? ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 100,
        width: Constants.getScreenWidth(context) / 3 - 15,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    icon,
                    color: Colors.white,
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
