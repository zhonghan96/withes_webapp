import 'package:flutter/material.dart';

final List<Map<String, Object>> jsonResponse = [
  {
    'questionText': 'Question 1',
    'answers': [
      {'answerText': 'Response 1'},
      {'answerText': 'Response 2'},
      {'answerText': 'Response 3'}
    ]
  },
  {
    'questionText': 'Question 2',
    'answers': [
      {'answerText': 'Response 1'},
      {'answerText': 'Response 2'},
      {'answerText': 'Response 3'}
    ]
  },
  {
    'questionText': 'Question 3',
    'answers': [
      {'answerText': 'Response 1'},
      {'answerText': 'Response 2'},
      {'answerText': 'Response 3'}
    ]
  }
];

class SurveyQuestionWidget extends StatefulWidget {
  const SurveyQuestionWidget({super.key});

  @override
  State<SurveyQuestionWidget> createState() => _SurveyQuestionWidgetState();
}

class _SurveyQuestionWidgetState extends State<SurveyQuestionWidget> {
  int questionIndex = 0;

  void _questionProgress() {
    setState(() {
      questionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(jsonResponse[questionIndex]['questionText'].toString()),
      ...(jsonResponse[questionIndex]['answers'] as List<Map<String, Object>>)
          .map((answer) {
        return ElevatedButton(
          child: Text(answer['text'].toString()),
          onPressed: () {
            _questionProgress();
          }, //Function for response processing goes here
        );
      })
    ]);
  }
}
