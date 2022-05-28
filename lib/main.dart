import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userQuestion = '';
  String userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(userAnswer,
                        style: const TextStyle(
                          fontSize: 20,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisExtent: 97,
                    ),
                    itemBuilder: (context, index) {
                      switch (index) {
                      // Clear button
                        case 0:
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = '';
                                userAnswer = '';
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.green,
                            textColor: Colors.white,
                          );

                      // Delete button
                        case 1:
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                if (userQuestion.isNotEmpty) {
                                  userQuestion = userQuestion
                                      .substring(0, userQuestion.length - 1);
                                }
                              });
                            },
                            buttonText: buttons[index],
                            color: Colors.red,
                            textColor: Colors.white,
                          );

                      // Equal button
                        case 19:
                          return MyButton(
                            buttonTapped: () {
                              if (userQuestion.isNotEmpty) {
                                setState(() {
                                  equalPressed();
                                });
                              }
                            },
                            buttonText: buttons[index],
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                          );

                      // Rest of the buttons
                        default:
                          return MyButton(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            buttonText: buttons[index],
                            color: isOperator(buttons[index])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.deepPurple,
                          );
                      }
                    })),
          ),
        ],
      ),
    );
  }

  bool isOperator(String value) {
    return (value == '%' ||
        value == '/' ||
        value == 'x' ||
        value == '-' ||
        value == '+' ||
        value == '=');
  }

  void equalPressed() {
    String finalQuestion = userQuestion.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
