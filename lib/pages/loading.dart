import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpTime() async {
    WorldTime obj = new WorldTime(
        location: 'Bengaluru', flag: 'India.png', url: 'Asia/Kolkata');
    await obj.getTime();
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': obj.location,
      'flag': obj.flag,
      'time': obj.time,
      'isDayTime': obj.isDayTime
    });
  }

  @override
  void initState() {
    super.initState();
    setUpTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SpinKitWanderingCubes(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
