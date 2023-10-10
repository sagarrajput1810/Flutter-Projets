import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async{
      WorldTime instance = WorldTime('Asia/Kolkata','India', 'kolkata.png');
      await instance.getTime();
      Navigator.pushReplacementNamed(context, '/home',arguments: {
        'location': instance.location,
        'flag':instance.flag,
        'time':instance.time,
        'isDaytime': instance.isDaytime,
      });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[900],
      body: Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 150.0,
        ),

      ),
    );
  }
}
