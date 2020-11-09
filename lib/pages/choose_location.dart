import 'package:flutter/material.dart';
import 'package:netninja_flutter_world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  Map data = {};

  List<WorldTime> locations = [];

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    List timezones = data['timezones'];

    for (var i = 0; i < timezones.length; i++) {
      WorldTime instance = new WorldTime(
        url: timezones[i],
        location: timezones[i].substring(timezones[i].indexOf('/') + 1),
      );
      locations.add(instance);
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text('Choose a Location'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {},
                title: Text(locations[index].location),
                leading: Icon(Icons.map),
              ),
            ),
          );
        },
      ),
    );
  }
}
