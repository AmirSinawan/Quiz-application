import 'package:flutter/material.dart';
import 'package:quizapp/model.dart';
//import 'package:quizappforstudents/model.dart';
//import 'package:singapp/model.dart';

class QuiezScreen extends StatefulWidget {
  const QuiezScreen({Key? key}) : super(key: key);

  @override
  State<QuiezScreen> createState() => _QuiezScreenState();
}

class _QuiezScreenState extends State<QuiezScreen> {
  List<Questions> questionList = getquestions();

  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 80),
      appBar: AppBar(title: Text("Quiez App")),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Quiez App For Students",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            _questionWidget(),
            _answerList(),
            _nextButton(),
          ],
        ),
      ),
    );
  }

  _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Quuestion ${currentQuestionIndex + 1}/${questionList.length.toString()}",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.indigoAccent,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        )
      ],
    );
  }

  _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answerList
          .map(
            (e) => _answerButton(e),
          )
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(answer.answerText),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: isSelected ? Colors.orangeAccent : Colors.white,
          onPrimary: isSelected ? Colors.white : Colors.black,
        ),
        onPressed: () {
          if (selectedAnswer == null) {
            if (answer.isCorrect) {
              score++;
            }

            setState(() {
              selectedAnswer = answer;
            });
          }
        },
      ),
    );
  }

  _nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 48,
      child: ElevatedButton(
        child: Text(isLastQuestion ? " Submit" : "Next"),
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: Colors.blueAccent,
          onPrimary: Colors.white,
        ),
        onPressed: () {
          if (isLastQuestion) {
            showDialog(context: context, builder: (_) => _showScore());
          } else {
            setState(() {
              selectedAnswer = null;
              currentQuestionIndex++;
            });
          }
        },
      ),
    );
  }

  _showScore() {
    bool isPassed = false;

    if (score >= questionList.length * 0.6) {
      isPassed = true;
    }

    String title = isPassed ? "Passed" : "Failed";
    return AlertDialog(
      title: Text(title + "| Score is $score"),
      content: ElevatedButton(
        child: Text("Restart"),
        onPressed: () {
          Navigator.pop(context);
          currentQuestionIndex = 0;
          score = 0;
          selectedAnswer = null;
        },
      ),
    );
  }
}
