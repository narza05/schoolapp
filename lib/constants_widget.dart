import 'package:flutter/services.dart';
import 'package:schoolapp/constants.dart';
import 'package:schoolapp/imports.dart';

class ConstantsWidget {

  static getStatusBar(Color statusbarColor, Brightness iconColor){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusbarColor,
        // statusBarIconBrightness: iconColor,
    )
    );
  }



  static getNavigationAppBar(Widget? widget1, String title, Widget? widget2) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      decoration: BoxDecoration(
          color: Constants.myBlue,
          boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(0, 1),blurRadius: 5)]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: widget1 == null ? 0 : 1,child: Container(child: widget1)),
          SizedBox(width: 10,),
          Expanded(flex: 5,child: Align(alignment: Alignment.center,
            child: Text(title , textAlign: TextAlign.center,style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins",
              fontSize: 20,
            ),),
          )),
          Expanded(flex: 1,child: Container(child: widget2))
        ],
      ),
    );
  }

  static getBasicAppBar(Widget? widget1, String title, Widget? widget2) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 55,
      decoration: BoxDecoration(
          color: Constants.backgroundgrey,
          boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(0, 1),blurRadius: 5)]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: widget1 == null ? 0 : 1,child: Container(child: widget1)),
          SizedBox(width: 10,),
          Expanded(flex: 5,child: Align(alignment: Alignment.center,
            child: Text(title , textAlign: TextAlign.center,style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontSize: 20,
            ),),
          )),
          Expanded(flex: 1,child: Container(child: widget2))
        ],
      ),
    );
  }

  static getNavigationScreen(BuildContext context, Widget child){
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Constants.backgroundgrey,
        child: SingleChildScrollView(
          child: Container(
            height: Constants.getScreenHeight(context)-56,
            child: Expanded(
              child: child,
            ),
          ),
        ),
      ),
    );
  }


  static getBasicScreen(BuildContext context, Widget child){
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Constants.backgroundgrey,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Constants.backgroundgrey,
              child: SingleChildScrollView(
                child: Container(
                  height: Constants.getScreenHeight(context),
                  child: child,
                ),
              ),
            )),
      ),
    );
  }
}
