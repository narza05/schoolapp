import 'package:flutter/services.dart';
import 'package:schoolapp/imports.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int screenIndex = 0;
  List screens = [Home()];
  List appbarColors = [
    Constants.myBlue,
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.black));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Constants.backgroundgrey,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    height: Constants.getScreenHeight(context)),
                child: Expanded(
                  child: Column(
                    children: [
                      screens[screenIndex],
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 51,
                          child: Column(
                            children: [
                              Container(color: Colors.grey.withOpacity(0.2),height: 1,),
                              GNav(
                                  iconSize: 20,
                                  activeColor: Colors.black,
                                  color: Colors.grey,
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                                  backgroundColor: Constants.backgroundgrey,
                                  onTabChange: (index) {},
                                  tabs: [
                                    GButton(
                                      icon: Icons.home,
                                    ),GButton(
                                      icon: Icons.notifications,
                                    ),GButton(
                                      icon: Icons.person,
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
