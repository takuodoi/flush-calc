import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class Problem {
  final int lhs;
  final int rhs;
  final int answer;
  final String operator;

  Problem(this.lhs, this.operator, this.rhs, this.answer);

  String getProblem() {
    return lhs.toString() + ' ' + operator + ' ' + rhs.toString();
  }

  String getAnswer() {
    return this.answer.toString();
  }

  String show(bool withAnswer) {
    String value = this.getProblem();
    if (withAnswer) {
      value += ' = ' + this.getAnswer();
    }

    return value;
  }
}

List<Problem> generateProblems()
{
  Random random = Random();

  List<Problem> problems = List<Problem>();
  for (int i = 0; i < 60; ++i) {
    bool ok = false;
    int a = 0;
    int b = 0;
    while (!ok) {
      a = random.nextInt(10);
      b = random.nextInt(10);
      ok = (a + b <= 10);
    }
    problems.add(Problem(a, '+', b, a + b));
  }

  return problems;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flush Calc',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WaitingPage(title: 'Flush Calc'),
    );
  }
}

class WaitingPage extends StatefulWidget
{
  final String title;

  WaitingPage({Key key, this.title}) : super(key: key);

  @override
  _WaitingPageState createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("スタート", style: TextStyle(fontSize: 96.0),),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProblemPage()),
            );
          },
        ),
      ),
    );
  }
}

class ProblemPage extends StatefulWidget
{
  @override
  _ProblemPageState createState() => _ProblemPageState(generateProblems());
}

class _ProblemPageState extends State<ProblemPage> {

  int index;
  bool showAnswer;
  List<Problem> problems;

  _ProblemPageState(this.problems);

  @override
  void initState() {
    super.initState();

    this.index = 0;
    this.showAnswer = false;
  }

  @override
  Widget build(BuildContext context) {
    Problem problem = this.problems[this.index];
    return Scaffold(
      appBar: AppBar(
        title: Text("もんだい", style: TextStyle(fontSize: 24.0),),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child:Center(
          child: Text(problem.show(this.showAnswer), style: TextStyle(fontSize: 196.0),),
        ),
        onTap: () {
          if (this.problems.length == this.index + 1 && this.showAnswer) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ResultPage()),
            );
          } else {
            setState(() {
              if (!this.showAnswer) {
                this.showAnswer = true;
              } else {
                ++this.index;
                this.showAnswer = false;
              }
            });
          }
        }
      ),
    );
  }
}

class ResultPage extends StatefulWidget
{
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("けっか", style: TextStyle(fontSize: 24.0),),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("もういっかい", style: TextStyle(fontSize: 96.0),),
          color: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProblemPage()),
            );
          },
        ),
      ),
    );
  }
}