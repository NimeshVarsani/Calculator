import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  double buttonBorderRadius = 50.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "⌫"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == ""){
          equation = "0";
        }
      }

      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
          print(e);
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }


  Widget buildButton(BuildContext context, String buttonText, double buttonHeight, Color buttonColor){
    return Padding(
      padding: EdgeInsets.all(1),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1 * (buttonHeight),
        decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(buttonBorderRadius)),
        child: TextButton(
            style: TextButton.styleFrom(
                // side: const BorderSide(
                //     color: Colors.white,
                //     width: 1,
                //     style: BorderStyle.solid
                // ),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonBorderRadius))
            ),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white
              ),
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: [

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize)),
          ),

          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize)),
          ),

          const Expanded(
            child: Divider(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton(context, "C", 1, Colors.orange.shade700),
                          buildButton(context,"⌫", 1, Colors.blue),
                          buildButton(context,"÷", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(context,"7", 1, Colors.grey.shade800),
                          buildButton(context,"8", 1, Colors.grey.shade800),
                          buildButton(context,"9", 1, Colors.grey.shade800),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(context,"4", 1, Colors.grey.shade800),
                          buildButton(context,"5", 1, Colors.grey.shade800),
                          buildButton(context,"6", 1, Colors.grey.shade800),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(context,"1", 1, Colors.grey.shade800),
                          buildButton(context,"2", 1, Colors.grey.shade800),
                          buildButton(context,"3", 1, Colors.grey.shade800),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(context,".", 1, Colors.grey.shade800),
                          buildButton(context,"0", 1, Colors.grey.shade800),
                          buildButton(context,"00", 1, Colors.grey.shade800),
                        ]
                    ),
                  ],
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton(context,"×", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(context,"-", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(context,"+", 1, Colors.blue),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton(context,"=", 2, Colors.orange.shade700),
                        ]
                    ),
                  ],
                ),
              )
            ],
          ),


        ],
      ),

    );
  }
}
