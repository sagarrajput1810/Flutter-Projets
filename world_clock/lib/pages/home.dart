import 'package:flutter/material.dart';
import 'dart:convert';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
    Map data = {};
  @override
  Widget build(BuildContext context) {
    var argument = ModalRoute.of(context)!.settings.arguments;

    String value = json.encode(argument) as String;
     data = data.isNotEmpty ? data :json.decode(value);
    String BGimage = data['isDaytime'] ? 'assets/images/day.jpg': 'assets/images/night.jpg';
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(BGimage),
            fit: BoxFit.cover,

          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
              children: [
                IconButton(onPressed:() async {
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'time' : result['time'],
                      'location' : result['location'],
                      'isDaytime' : result['isDaytime'],
                      'flag' : result['flag']
                    };
                  });
                  },
                  icon: Icon(Icons.edit_location),
                  iconSize: 50.0,
                ),
                SizedBox(height: 20.0,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['location'],
                      style: TextStyle(
                        fontSize: 35.0,
                        letterSpacing: 2.0
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(data['time'],
                  style: TextStyle(
                      fontSize: 70.0,
                      letterSpacing: 2.0
                  ),
                ),
              ],
          ),
        ),
      ),
    );
  }
}
