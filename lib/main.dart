import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:schoolapp/constants.dart';
import 'package:schoolapp/home/home.dart';
import 'package:schoolapp/navigation.dart';
import 'package:schoolapp/notes/add_notes.dart';
import 'package:schoolapp/notes/all_notes.dart';
import 'package:schoolapp/pre_home/register.dart';
import 'package:schoolapp/quiz/all_quiz.dart';
import 'package:schoolapp/quiz/quiz.dart';
import 'package:schoolapp/quiz/submitted_quiz.dart';

void main() {
  runApp(const SchoolApp());
}

class SchoolApp extends StatefulWidget {
  const SchoolApp({Key? key}) : super(key: key);

  @override
  State<SchoolApp> createState() => _SchoolAppState();
}

class _SchoolAppState extends State<SchoolApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation(),
    );
  }
}
