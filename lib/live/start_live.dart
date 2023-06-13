import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:schoolapp/imports.dart';
import 'package:http/http.dart' as http;
import 'package:schoolapp/live/live.dart';
import 'package:schoolapp/live/start_live_model.dart';
import 'package:toast/toast.dart' as Toast;

class StartLive extends StatefulWidget {
  @override
  State<StartLive> createState() => _StartLiveState();
}

class _StartLiveState extends State<StartLive> {
  String selectedDate = Constants.getCurrentDate();
  String selectedTime = Constants.getCurrentTime();
  String code = Constants.getCurrentDate() +
      Constants.getCurrentTime() +
      "schoolapp".replaceAll(" ", "");
  TextEditingController codeText = TextEditingController();
  TextEditingController titleText = TextEditingController();
  List<StartLiveModel> list = [];

  addConference() async {
    var response = await http.post(Uri.parse(Constants.ADD_CONFERENCE), body: {
      "date": selectedDate,
      "time": selectedTime,
      "code": code,
    });
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      Toast.Toast.show(result['message']);
      print(result['message']);
    }
  }

  getConference() async {
    var response = await http.get(Uri.parse(Constants.GET_CONFERENCE));
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      for (var obj in result) {
        setState(() {
          list.add(StartLiveModel(obj['date'], obj['time'], obj['code']));
        });
      }
    }
  }

  getList() {
    return Expanded(
      child: ListView.builder(
          itemCount: list.length, itemBuilder: (context, position) {

      }),
    );
  }

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
                  Icons.live_tv,
                  color: Colors.white,
                ),
                "Live",
                null),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(bottom: 20),
                  height: 110,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Constants.myBlue,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))),
                  child: GestureDetector(
                    onTap: () {
                      code = Constants.getCurrentDate() +
                          Constants.getCurrentTime() +
                          "schoolapp".replaceAll(" ", "");
                      print(code);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Live(conferenceID: code);
                      }));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 65, right: 65, bottom: 55, top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Constants.mygrey,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Start Instant Conference",
                            style: TextStyle(color: Colors.black, fontFamily: "Poppins"),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: codeText,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "Enter Code",
                        filled: true,
                        // fillColor: Color(0xffebebeb),
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Constants.backgroundgrey.withOpacity(0),
                          ),
                        )),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                print(codeText.text);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Live(conferenceID: codeText.text);
                }));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Constants.myBlue,
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  "Join Conference",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Constants.backgroundgrey,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Text(
                      "Schedule Conference",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Date_Time("Date", Icons.calendar_month, selectedDate,
                            () async {
                          DateTime? date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(3000));
                          if (date != null) {
                            setState(() {
                              print(date);
                              selectedDate = date
                                  .toString()
                                  .replaceAll("00:00:00.000", "");
                            });
                          }
                        }),
                        SizedBox(
                          width: 10,
                        ),
                        Date_Time("Time", Icons.timer, selectedTime, () async {
                          TimeOfDay? time = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (time != null) {
                            setState(() {
                              print(time);
                              selectedTime = time.format(context).toString();
                            });
                          }
                        })
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: titleText,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "Title",
                          filled: true,
                          // fillColor: Color(0xffebebeb),
                          fillColor: Colors.white,
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Constants.backgroundgrey.withOpacity(0),
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        code = Constants.getCurrentDate() +
                            Constants.getCurrentTime() +
                            "schoolapp".replaceAll(" ", "");
                        addConference();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 50,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Constants.myBlue,
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          "Schedule",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    getList(),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Expanded Date_Time(
      String title, IconData icon, String selected, Function() ontap) {
    return Expanded(
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          Container(
            decoration: BoxDecoration(
                color: Constants.mygrey,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: ontap,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        icon,
                        size: 20,
                      ),
                    )),
                Text(
                  selected,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
