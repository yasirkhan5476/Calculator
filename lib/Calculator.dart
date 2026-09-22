import 'package:flutter/material.dart';

class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  // Whatever is currently shown on the screen.
  String display = '0';

  // The buttons, laid out exactly the way they will appear:
  // 4 rows, 4 buttons per row.
  final List<List<String>> buttonRows = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', '*'],
    ['1', '2', '3', '-'],
    ['C', '0', '=', '+'],
  ];

  // ---------- FUNCTIONS ----------

  // Runs whenever any button is tapped.
  void onButtonTap(String label) {
    setState(() {
      if (label == 'C') {
        display = '0';
      } else if (label == '=') {
        display = calculateResult(display);
      } else {
        if (display == '0') {
          display = label;
        } else {
          display = display + label;
        }
      }
    });
  }

  // Very simple calculator: only handles ONE operator, e.g. "12+7".
  // Good enough for a first Flutter UI project.
  String calculateResult(String expression) {
    String operator = '';

    // Find the operator
    for (int i = 0; i < expression.length; i++) {
      String character = expression[i];

      if (character == '+' ||
          character == '-' ||
          character == '*' ||
          character == '/') {
        operator = character;
        break;
      }
    }

    if (operator == '') {
      return expression;
    }

    // Split all numbers
    List<String> parts = expression.split(operator);

    double result = double.parse(parts[0]);

    // Calculate with all remaining numbers
    for (int i = 1; i < parts.length; i++) {
      double number = double.parse(parts[i]);

      if (operator == '+') {
        result += number;
      } else if (operator == '-') {
        result -= number;
      } else if (operator == '*') {
        result *= number;
      } else if (operator == '/') {
        if (number == 0) {
          return 'Error';
        }
        result /= number;
      }
    }

    return result.toString();
  }
  // Picks a color for a button just by looking at its label.
  Color colorForButton(String label) {
    if (label == 'C') {
      return Colors.red;
    } else if (label == '+' || label == '-' || label == '*' ||
        label == '/' || label == '=') {
      return Colors.orange;
    } else {
      return Colors.grey.shade800;
    }
  }


  Widget myComponent(String label, {void Function()? onTap}){
    return InkWell(
      onTap:onTap,
      child: Container(
        height: 100,
        width: 150,
        color: Colors.blue,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Simplified Calculator')),
      body: InkWell(
        onTap: (){
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey,
          child: Column(
            children: [
              // ----- SCREEN: shows the current display text -----
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(20),
                
                child: Text(
                  display,
                  style: const TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
              // Row(
              //   children: [
              //     myComponent("1", onTap: (){
              //       display ="1";
              //     }),
              //     myComponent("2"),
              //     myComponent("3"),
              //     myComponent("4"),
              //
              //   ],
              // ),

              // ----- BUTTONS: one Row per row of buttons -----
              // FOR LOOP: go through every row in buttonRows.
              for (List<String> row in buttonRows)
                Row(
                  children: [

                    for (String label in row)
                      Expanded(

                        child: GestureDetector(
                          onTap: () => onButtonTap(label),
                          child: Container(
                            width: 90,
                            height: 90,
                            margin: const EdgeInsets.all(6),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: colorForButton(label),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              label,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
