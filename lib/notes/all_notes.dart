import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:schoolapp/imports.dart';
import 'package:schoolapp/notes/add_notes.dart';
import 'package:schoolapp/notes/all_notes_model.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:http/http.dart' as http;
import 'notes_view.dart';

class AllNotes extends StatefulWidget {
  const AllNotes({super.key});

  @override
  State<AllNotes> createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {
  var controller = ScrollController();
  var scrolled = false;
  int index = 0;
  List<AllNotesModel> mainList = [];
  List<AllNotesModel> copyList = [];

  getNotes() async {
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Center(
    //         child: CircularProgressIndicator(backgroundColor: Colors.red,),
    //       );
    //     });
    var response = await http.get(Uri.parse(Constants.GET_NOTES));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      for (var obj in result) {
        mainList.add(AllNotesModel(obj["title"], obj["file"], obj["subject"]));
      }
      setState(() {
        copyList = mainList;
      });
    }
    // Navigator.of(context, rootNavigator: true).pop();
  }

  listListener() {
    // print(controller.position.pixels);
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() {
        if (scrolled == false) {
          scrolled = true;
        }
      });
    } else if (scrolled == true) {
      if (controller.position.pixels < controller.position.maxScrollExtent) {
        setState(() {
          scrolled = false;
        });
      }
    }
  }

  filterList(String text) {
    setState(() {
      if (text == "") {
        copyList = mainList;
      } else {
        copyList = mainList
            .where((element) =>
                element.title.toLowerCase().contains(text.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      getNotes();
      controller.addListener(() {
        listListener();
      });
    });
  }

  @override
  void dispose() {
    controller.removeListener(() {
      listListener();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
    return ConstantsWidget.getBasicScreen(
        context,
        Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                ConstantsWidget.getBasicAppBar(
                    GestureDetector(
                      onTap: () {
                        Toast.Toast.show("msg");
                        setState(() {
                          scrolled = !scrolled;
                        });
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    "Notes",
                    null),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: 35,
                        child: TextField(
                          onChanged: (text) {
                            filterList(text);
                          },
                          style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                          decoration: InputDecoration(
                              hintText: "Search",
                              filled: true,
                              fillColor: Constants.mygrey.withOpacity(0.6),
                              contentPadding:
                                  EdgeInsets.only(left: 15, right: 35),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide(
                                      color: Colors.white.withOpacity(0)))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.search,
                              size: 20,
                            )),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(overscroll: false),
                    child: ListView.builder(
                        controller: controller,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: copyList.length,
                        itemBuilder: (context, position) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return NotesView(
                                    copyList[position].file.contains(".pdf")
                                        ? true
                                        : false,
                                    copyList[position].file);
                              }));
                            },
                            child: Container(
                              width: double.infinity,
                              margin:
                                  EdgeInsets.only(left: 10, right: 10, top: 10),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Constants.myBluefaded,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Row(
                                children: [
                                  Icon(
                                    copyList[position].file.contains(".pdf")
                                        ? Icons.picture_as_pdf
                                        : Icons.image,
                                    color:
                                        copyList[position].file.contains(".pdf")
                                            ? Colors.amber
                                            : Colors.red,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        copyList[position].title,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        copyList[position].subject,
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 11),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                color: Colors.transparent,
                height: scrolled ? 20 : 60,
                // padding: EdgeInsets.only(top: scrolled ? 40 : 0),
                duration: Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddNotes();
                    }));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Constants.myBlue,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Text(
                      "Add Notes",
                      style:
                          TextStyle(fontFamily: "Poppins", color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
