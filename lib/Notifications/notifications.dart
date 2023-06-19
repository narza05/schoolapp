import 'package:schoolapp/imports.dart';
import 'package:toast/toast.dart' as Toast;

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    ConstantsWidget.getStatusBar(Constants.myBlue, Brightness.light);
    Toast.ToastContext().init(context);
    return ConstantsWidget.getNavigationScreen(
        context,
        Column(
          children: [
            ConstantsWidget.getNavigationAppBar(
                Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                "Alerts",
                null),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, position) {
                    return Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 50,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Color(0xffe39035),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                  child: Text(
                                "Notes",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              flex: 10,
                              child: Text(
                                "Biology notes were uploadedasss",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Poppins",
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: Text(
                                textAlign: TextAlign.center,
                                "2d",
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: "Poppins"),
                              )),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
