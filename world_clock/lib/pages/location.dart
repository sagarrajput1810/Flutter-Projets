import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';
class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {

  List<WorldTime> locations = [
    WorldTime('Asia/Kolkata','India', 'kolkata.png'),
    WorldTime('Europe/London', 'London', 'uk.png'),
    WorldTime('Europe/Berlin', 'Athens', 'greece.png'),
    WorldTime('Africa/Cairo', 'Cairo', 'egypt.png'),
    WorldTime('Europe/Moscow', 'Moscow', 'Moscow.png'),
    WorldTime('America/Chicago', 'Chicago', 'usa.png'),
    WorldTime('America/New_York', 'New York', 'usa.png'),
    WorldTime('Asia/Seoul', 'South Korea', 'SouthKorea.png'),
    WorldTime('Asia/Jakarta', 'Jakarta', 'indonesia.png'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDaytime': instance.isDaytime,});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text('Choose location'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: locations.length,
            itemBuilder: (context,index){
            return Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/${locations[index].flag}'),
                ),
              ),
            );
            },
        ),
      ),
    );
  }
}
