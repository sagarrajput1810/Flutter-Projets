import 'package:flutter/material.dart';
import 'package:instagram/responsive/dimentions.dart';
class ResponsiveLayout extends StatelessWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key, required this.webScreenLayout, required this.mobileScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrains){
      if(constrains.maxWidth > webScreensize){
          return webScreenLayout;
      }
      return mobileScreenLayout; 
    },);
  }
}
