import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          elevation: 4,
          title: Center(
            child: Text(
              'Quizzler',
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          type: AlertType.success,
          style: AlertStyle(
            backgroundColor: Colors.white10,
            titleStyle:
                TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
            descStyle:
                TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
            overlayColor: Colors.black,
          ),
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        quizBrain.reset();

        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer)
          scoreKeeper.add(Icon(
            Icons.check_circle_sharp,
            color: Colors.green,
            size: 30,
          ));
        else
          scoreKeeper.add(Icon(
            Icons.error_sharp,
            color: Colors.red,
            size: 30,
          ));

        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            '*Answers',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.white,
          indent: 50,
          endIndent: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: scoreKeeper,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              splashColor: Colors.black38,
              highlightColor: Colors.black38,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              splashColor: Colors.black38,
              highlightColor: Colors.black38,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
