import 'package:flutter/material.dart';

class Chessboard extends StatefulWidget {
  const Chessboard({super.key});

  @override
  State<Chessboard> createState() => _ChessboardState();
}

class _ChessboardState extends State<Chessboard> {
  double num1=0;
  double num2=0;
  String display="0";
  String operand="";
  String input="";
  void pressedbutton(String buttontext){
      setState(() {
          if(buttontext=="C"){
             num1=0;
             num2=0;
             display="0";
             operand="";
             input="";
          }else if(buttontext=="+"||buttontext=="-"||buttontext=="/"||buttontext=="*"){
            num1=double.parse(display);
            operand=buttontext;
            input="";
          }else if (buttontext == "=") {
            num2 = double.parse(display);
            if (operand == "+") {
              input = (num1 + num2).toString();
            } if (operand == "-") {
              input = (num1 - num2).toString();
            } if (operand == "*") {
              input = (num1 * num2).toString();
            } if (operand == "/") {
              input = num2 != 0 ? (num1 / num2).toString() : "Error";
            }
            display = input;
            operand = "";
          } else {
            input = input + buttontext;
            display = input;
          }
      });

  }

  Widget _Buildbutton(String buttontext,Color buttoncolor,{Color? textcolor}){
    return Expanded(
      child: Padding(padding: EdgeInsets.all(4.0),
        child:ElevatedButton(onPressed: () => pressedbutton(buttontext),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttoncolor, // Background color
              foregroundColor: textcolor,      // Text/Icon color
              elevation: 8.0,                   // Shadow depth
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
            ),
            child: Text(buttontext,style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: textcolor),)),

      ),
    );
  }
 Color getbuttoncolor(){
    return Colors.grey;
 }
  Color getbuttoncolorbackground(){
    return Colors.orange;
  }
  Color equaltobutton(){
    return Colors.pink;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              display,
              style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              _Buildbutton("9",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("8",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("7",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("C",getbuttoncolorbackground(),textcolor: getbuttoncolor()),

            ],
          ),
          Row(
            children: [
              _Buildbutton("6",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("5",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("4",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("+",getbuttoncolorbackground(),textcolor: getbuttoncolor()),

            ],
          ),
          Row(
            children: [
              _Buildbutton("3",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("2",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("1",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("*",getbuttoncolorbackground(),textcolor: getbuttoncolor()),

            ],
          ),
          Row(
            children: [
              _Buildbutton(".",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("0",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("00",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("=",equaltobutton(),textcolor: getbuttoncolor()),

            ],
          ),
          Row(
            children: [
              _Buildbutton("/",getbuttoncolor(),textcolor: Colors.white),
              _Buildbutton("-",getbuttoncolor(),textcolor: Colors.white),


            ],
          ),
        ],
      ),
    );
  }
}
