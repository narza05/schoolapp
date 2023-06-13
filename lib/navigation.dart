import 'package:flutter/services.dart';
import 'package:schoolapp/imports.dart';

import 'live/start_live.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int screenIndex = 0;
  List screens = [Home(), StartLive()];
  List appbarColors = [
    Constants.myBlue,
  ];

  PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Constants.myBlue,
          statusBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              currentIndex: screenIndex,
              onTap: (value) {
                screenIndex = value;
                _pageController.animateToPage(
                  value,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.linear,
                );

                setState(() {});
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home_outlined,size: 17,), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.live_tv,size: 17,), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.message,size: 17,), label: "Home"),
                BottomNavigationBarItem(icon: Icon(Icons.person,size: 17,), label: "Home"),
              ]),
          body: ScrollConfiguration(
            behavior: ScrollBehavior().copyWith(overscroll: false),
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  screenIndex = page;
                });
              },
              children: <Widget>[
                Home(),
                StartLive()
              ],
            ),
          ),
        ),
      ));

        // SafeArea(
        //   child: Container(
        //     width: double.infinity,
        //     height: double.infinity,
        //     color: Constants.backgroundgrey,
        //     child: SingleChildScrollView(
        //       child: ConstrainedBox(
        //         constraints: BoxConstraints.tightFor(
        //             height: Constants.getScreenHeight(context)),
        //         child: Expanded(
        //           child: Column(
        //             children: [
        //               screens[screenIndex],
        //               Align(
        //                 alignment: Alignment.bottomCenter,
        //                 child: Container(
        //                   height: 51,
        //                   child: Column(
        //                     children: [
        //                       Container(
        //                         color: Colors.grey.withOpacity(0.2),
        //                         height: 1,
        //                       ),
                              // GNav(
                              //     iconSize: 20,
                              //     activeColor: Colors.black,
                              //     color: Colors.grey,
                              //     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                              //     backgroundColor: Constants.backgroundgrey,
                              //     onTabChange: (index) {
                              //       setState(() {
                              //         screenIndex = index;
                              //       });
                              //     },
                              //     tabs: [
                              //       GButton(
                              //         icon: Icons.home,
                              //       ),GButton(
                              //         icon: Icons.live_tv,
                              //       ),GButton(
                              //         icon: Icons.message,
                              //       ),GButton(
                              //         icon: Icons.person,
                              //       ),
                              //     ]),
    //                         ],
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
