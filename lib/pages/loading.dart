import 'package:flutter/material.dart';
import 'package:netninja_flutter_world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = 'loading...';
  void setupWorldTime() async {
    WorldTime instance = WorldTime(location: 'Berlin', url: 'Europe/Berlin');
    await instance.getTime();
    // await instance.getAllTimes();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
    // Navigator.pushReplacementNamed(context, '/location', arguments: {
    //   'timezones': instance.timezones,
    // });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
