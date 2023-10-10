import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  late String location;// location name for the UI
  late String time; // the time is that location
  late String flag; // url to an assets flag icon
  late String url; // url for location api end point
  late bool isDaytime;

  WorldTime (a,b,c){
    this.url = a;
    this.location = b;
    this.flag = c;
  }

  Future<void> getTime() async{
    // make the request
    Response response= await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
    Map data = jsonDecode(response.body);
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1,3);
    DateTime now = DateTime.parse(dateTime);
    now = now.add(Duration(hours: int.parse(offset),));
    now = now.add(Duration(minutes: int.parse(data['utc_offset'].substring(4,6)),));


    isDaytime = now.hour > 6 && now.hour < 18 ? true : false;

    // set time property
    time = DateFormat.jm().format(now);
  }
}