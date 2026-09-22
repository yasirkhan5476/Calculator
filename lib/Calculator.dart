import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
   Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String display = '0';

  final List<List<String>> buttonRows = [
    ['7', '8', '9', '/'],
    ['4', '5', '6', '*'],
    ['1', '2', '3', '-'],
    ['C', '0', '=', '+'],
  ];

  // --------------------------------------------------
  // BUTTON FUNCTION
  // --------------------------------------------------

  void onButtonTap(String label) {
    setState(() {
      if (label == 'C') {
        display = '0';
      } else if (label == '=') {
        display = calculateResult(display);
      } else {
        if (display == '0' || display == 'Error') {
          display = label;
        } else {
          display += label;
        }
      }
    });
  }

  // --------------------------------------------------
  // CALCULATE RESULT
  // --------------------------------------------------

  String calculateResult(String expression) {
    String operator = '';

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

    if (operator.isEmpty) {
      return expression;
    }

    try {
      List<String> parts = expression.split(operator);

      if (parts.length != 2 || parts[0].isEmpty || parts[1].isEmpty) {
        return 'Error';
      }

      double number1 = double.parse(parts[0]);
      double number2 = double.parse(parts[1]);

      double result;

      if (operator == '+') {
        result = number1 + number2;
      } else if (operator == '-') {
        result = number1 - number2;
      } else if (operator == '*') {
        result = number1 * number2;
      } else {
        if (number2 == 0) {
          return 'Error';
        }

        result = number1 / number2;
      }

      if (result == result.toInt()) {
        return result.toInt().toString();
      }

      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }

  Color getButtonColor(String label) {
    // Clear button
    if (label == 'C') {
      return  Color(0xFFF3E8FF);
    }

    // Operators
    if (label == '+' || label == '-' || label == '*' || label == '/') {
      return  Color(0xFFE9D5FF);
    }

    // Equal button
    if (label == '=') {
      return  Color(0xFF7C3AED);
    }

    // Number buttons
    return Colors.white;
  }

  // --------------------------------------------------
  // BUTTON TEXT COLORS
  // --------------------------------------------------

  Color getTextColor(String label) {
    if (label == '=') {
      return Colors.white;
    }

    if (label == 'C') {
      return  Color(0xFF9333EA);
    }

    if (label == '+' || label == '-' || label == '*' || label == '/') {
      return  Color(0xFF7E22CE);
    }

    return  Color(0xFF312E81);
  }

  Widget calculatorButton(String label) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.all(6),

        child: GestureDetector(
          onTap: () => onButtonTap(label),

          child: Container(
            height: 75,

            decoration: BoxDecoration(
              color: getButtonColor(label),

              borderRadius: BorderRadius.circular(22),

              border: Border.all(color:  Color(0xFFE9D5FF), width: 1),

              boxShadow:  [
                BoxShadow(
                  color: Color(0x22000000),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),

            child: Center(
              child: Text(
                label,

                style: TextStyle(
                  color: getTextColor(label),
                  fontSize: label == 'C' ? 22 : 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFFAF7FF),

      appBar: AppBar(
        backgroundColor:  Color(0xFFFAF7FF),

        elevation: 0,

        title:  Text(
          'Calculator',
          style: TextStyle(
            color: Color(0xFF4C1D95),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16, vertical: 10),

          child: Column(
            children: [
              Expanded(
                flex: 3,

                child: Container(
                  width: double.infinity,

                  padding: EdgeInsets.all(25),

                  decoration: BoxDecoration(
                    color:   Color(0xFFF3E8FF),

                    borderRadius: BorderRadius.circular(30),

                    border: Border.all(
                      color:  Color(0xFFE9D5FF),
                      width: 1,
                    ),

                    boxShadow:  [
                      BoxShadow(
                        color: Color(0x227C3AED),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,

                    children: [
                         Text(
                        'RESULT',

                        style: TextStyle(
                          color: Color(0xFF9F7AEA),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),

                       SizedBox(height: 10),

                      FittedBox(
                        fit: BoxFit.scaleDown,

                        child: Text(
                          display,

                          style:  TextStyle(
                            color: Color(0xFF4C1D95),
                            fontSize: 52,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 20),
              Expanded(
                flex: 7,

                child: Column(
                  children: [
                    for (List<String> row in buttonRows)
                      Expanded(
                        child: Row(
                          children: [
                            for (String label in row) calculatorButton(label),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
