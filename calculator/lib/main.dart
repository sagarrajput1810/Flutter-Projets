import  'package:calculator/pages/home.dart';
import 'package:flutter/material.dart';
void main(){
  return runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
    },
  ));
}