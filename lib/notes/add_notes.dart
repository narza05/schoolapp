import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart' as Toast;
import 'package:schoolapp/imports.dart';
import 'package:http/http.dart' as http;

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleText = TextEditingController();
  TextEditingController subjectText = TextEditingController();
  String fileName = "Choose file...";
  String file64 = "";

  filePicker() async {
    var result = await FilePicker.platform.pickFiles(
        allowedExtensions: ["jpeg", "jpg", "png", "pdf"],
        type: FileType.custom);
    if (result != null) {
      var file = result.files.first;
      final bytes = File(file.path!).readAsBytesSync();
      file64 = base64Encode(bytes);
      print(file64);
      setState(() {
        fileName = file.name;
      });
    } else {
      Toast.Toast.show("Choose a file");
    }
  }

  uploadNotes()async{
    var response = await http.post(Uri.parse(Constants.ADD_NOTES), body: {
      "title" : titleText.text,
      "file" : file64,
      "filename" : fileName,
      "subject" : subjectText.text
    });

    if(response.statusCode==200){
      var result = jsonDecode(response.body);
      Toast.Toast.show(result['msg']);
    }
  }

  @override
  Widget build(BuildContext context) {
    Toast.ToastContext().init(context);
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
              child: Column(
                children: [
                  ConstantsWidget.getBasicAppBar(
                      Icon(Icons.arrow_back), "Notes", null),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        textField(titleText, "Write..."),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Subject",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        textField(subjectText, "Write..."),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Notes File",
                          style: TextStyle(
                              letterSpacing: 1,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 15),
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Constants.mygrey,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text(
                                fileName,
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontFamily: "Poppins",
                                  fontSize: 13,color: Colors.black54
                                ),
                              ),
                            )),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                filePicker();
                              },
                              child: CircleAvatar(
                                backgroundColor: Constants.mygrey,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.amber,
                                ),
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            uploadNotes();
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Constants.myBlue,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                "Upload",
                                style: TextStyle(
                                    letterSpacing: 1,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
    ;
  }

  SizedBox textField(
      TextEditingController? controller, String hint) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        style: TextStyle(letterSpacing: 1, fontFamily: "Poppins", fontSize: 13),
        decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Constants.mygrey.withOpacity(0.6),
            contentPadding: EdgeInsets.only(left: 15, right: 35),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white.withOpacity(0))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: Colors.white.withOpacity(0)))),
      ),
    );
  }
}
