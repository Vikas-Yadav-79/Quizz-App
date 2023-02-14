import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain oquizbrain = QuizBrain();

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
  void ansChecker(bool Userans) {
    bool Actualans = oquizbrain.getAnswer(questionnumber);
    if (Userans == Actualans) {
      print('You got it right');
    } else {
      print('You got it wrong');
    }
  }

  int questionnumber = 0;
  List<Icon> Scorekeeper = [];

  // List<String> questions = [
  //   'You can lead a cow down stairs but not up stairs.',
  //   'Approximately one quarter of human bones are in the feet.',
  //   'A slug\'s blood is green.'
  // ];
  // List<bool> answers =[false,true,true];

  // List<Questions> Questionbank = [
  //   Questions(q: 'You can lead a cow down stairs but not up stairs.', a: false),
  //   Questions(
  //       q: 'Approximately one quarter of human bones are in the feet.', a: true),
  //   Questions(q: 'A slug\'s blood is green.', a: true)
  // ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                // oquizbrain.Questionbank[questionnumber].questionText,
                oquizbrain.getQuestion(questionnumber),
                // 'This is where the question text will go.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                ansChecker(true);
                setState(() {
                  if (oquizbrain.isfinished(questionnumber) == true) {
                    Alert(
                      context: context,
                      title: 'Finished!',
                      desc: 'You\'ve reached the end of the quiz.',
                    ).show();

                    oquizbrain.reset(questionnumber);
                    Scorekeeper = [];
                    questionnumber =
                        oquizbrain.getQuestionNumber(questionnumber);
                  } else {
                    Scorekeeper.add(
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    );
                    questionnumber =
                        oquizbrain.getQuestionNumber(questionnumber);
                  }
                });
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'False',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  ansChecker(false);
                  setState(() {
                    if (oquizbrain.isfinished(questionnumber) == true) {
                      Alert(
                        context: context,
                        title: 'Finished!',
                        desc: 'You\'ve reached the end of the quiz.',
                      ).show();

                      oquizbrain.reset(questionnumber);
                      Scorekeeper = [];
                      questionnumber =
                          oquizbrain.getQuestionNumber(questionnumber);
                    } else {
                      Scorekeeper.add(
                        const Icon(
                          Icons.close,
                          color: Colors.red,
                        ),
                      );
                      questionnumber =
                          oquizbrain.getQuestionNumber(questionnumber);
                    }
                  });

                  //The user picked false.
                }),
          ),
        ),
        Row(
          children: Scorekeeper,
        )

        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
