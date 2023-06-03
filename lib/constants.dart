import 'package:schoolapp/imports.dart';




class Constants{
  static final Color backgroundgrey = Color(0xfff8f8f8);
  static final Color myBlue = Color(0xff0052bc);
  static final Color myBluefaded = Color(0x1a2c86ff);




  static double getScreenHeight(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    final mq = height - padding.top - padding.bottom;
    return mq;
  }
  static double getScreenWidth(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
     return width;
  }
}