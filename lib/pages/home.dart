import 'package:flutter/material.dart';
import 'package:netninja_flutter_world_time/services/world_time.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;

    String bgImage = data['isDayTime'] ? 'morning.jpg' : 'night.jpg';
    Color bgColor = data['isDayTime'] ? Colors.white : Colors.black54;
    Color textColor = data['isDayTime'] ? Colors.grey[800] : Colors.white70;

    void editLocation() async {
      WorldTime instance = WorldTime(location: 'Berlin', url: 'Europe/Berlin');
      await instance.getAllTimes();
      dynamic result =
          await Navigator.pushNamed(context, '/location', arguments: {
        'timezones': instance.timezones,
      });
      setState(() {
        data = {
          'time': result['time'],
          'location': result['location'],
          'isDayTime': result['isDayTime'],
        };
      });
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 110.0, 0, 0),
            child: Column(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    editLocation();
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: textColor,
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: textColor),
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 30.0,
                        letterSpacing: 2.0,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 68.0,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
