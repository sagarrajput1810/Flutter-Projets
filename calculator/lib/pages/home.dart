import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String s = '';
  String result = "0";
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Calculator"),

      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Center(child: Column(
          children: [
            Expanded(
              child: Container(
                height: 100,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container( child: Text("$s", style: TextStyle( fontSize: 50),),),
                    Container(child: Text("$result", style: TextStyle( fontSize: 50),),),
                  ],
                ),
              ),
            ),
            Column(
              children: [

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s ="";
                      result ="0";
                      }); }, child: Container(
                        height: 100,
                        child: Center(child: Text("C" , style: TextStyle( fontSize: 60),)
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular()),
                        ),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"/";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("/" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"*";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("x" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s.substring(0,s.length-1);}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("BS" , style: TextStyle( fontSize: 50),)),
                      )),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"7";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("7" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"8";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("8" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"9";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("9" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"-";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("-" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"4";
                      result ="0";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("4" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"5";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("5" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"6";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("6" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"+";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("+" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"1";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("1" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"2";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("2" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"3";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("3" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"^";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("P" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"/100";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("%" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+"0";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("0" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {setState(() {s = s+".";}); }, child: Container(
                        height: 100,
                        child: Center(child: Text("." , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                    Expanded(
                      child: ElevatedButton(onPressed:() {
                        // Parse expression:
                        Expression exp = Expression(s);
                        setState(() {
                          result = exp.eval().toString();
                        });

                      }, child: Container(
                        height: 100,
                        child: Center(child: Text("=" , style: TextStyle( fontSize: 60),)),
                      )),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
