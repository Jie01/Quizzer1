import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Quizzer(),
        ),
      ),
    );
  }
}

class Quizzer extends StatefulWidget {
  const Quizzer({Key key}) : super(key: key);

  @override
  _QuizzerState createState() => _QuizzerState();
}

class _QuizzerState extends State<Quizzer> {
  QuesBrain quesBrain = QuesBrain();

  List<Icon> useranses = [];

  void checkans(bool userans) {
    if (userans == quesBrain.quesans()) {
      useranses.add(Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      useranses.add(Icon(
        Icons.close,
        color: Colors.red,
      ));
    }

    if (quesBrain.nextQues() == true) {
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Completed all question'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('yeah'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('exit'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  useranses.clear();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Text(
              quesBrain.quesText(),
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ),
        ),
        Expanded(
          child: FlatButton(
              color: Colors.green,
              onPressed: () {
                setState(() {
                  checkans(true);
                });
              },
              child: Text(
                "True",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ),
        SizedBox(height: 20),
        Expanded(
          child: FlatButton(
              color: Colors.red,
              onPressed: () {
                setState(() {
                  checkans(false);
                });
              },
              child: Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
        ),
        SizedBox(height: 5),
        Row(
          children: useranses,
        )
      ],
    );
  }
}

class Question {
  String quesText;
  bool ans;

  Question({this.quesText, this.ans});
}

class QuesBrain {
  int _quesindex = 0; //控制題目第幾題

  List<Question> _question = [
    //題目庫
    Question(quesText: "hihihihih", ans: true),
    Question(quesText: "hihihihih2", ans: false),
    Question(quesText: "hihihihih3", ans: true),
  ];

  bool nextQues() {
    if (_quesindex < _question.length - 1) {
      _quesindex++;
      return false; // 當這條題目唔係最後，就跳去下一題
    } else {
      _quesindex = 0; //到最後嗰題就去翻第一題
      return true;
    }
  }

  String quesText() {
    return _question[_quesindex].quesText; //return 題目
  }

  bool quesans() {
    return _question[_quesindex].ans; //return題目對錯BOOL
  }
}
