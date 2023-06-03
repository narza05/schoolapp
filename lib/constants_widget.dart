import 'package:schoolapp/constants.dart';
import 'package:schoolapp/imports.dart';

class ConstantsWidget {
  static getAppBar(Widget widget1, String title, Widget? widget2) {
    return Container(
      color: Constants.myBlue,
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 60,
      child: Row(
        children: [
          Expanded(flex: 1,child: widget1),
          SizedBox(width: 10,),
          Expanded(flex: 5,child: Text("School Name", style: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
          ),)),
          Expanded(flex: 1,child: Container(child: widget2))
        ],
      ),
    );
  }
}
