import 'package:flutter/material.dart';
import 'package:mutendance/model/student.dart';
import 'package:mutendance/views/components/student.dart';

class AttendancePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            'Take Attendance',
            style: Theme.of(context).textTheme.headline4,
          ),
          SwitchListTile(
            title: Text('Mark Absents Only'),
            onChanged: null,
            value: true,
          ),
          Expanded(
              child: ListView.builder(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            itemCount: 200,
            itemBuilder: (context, position) {
              return StudentListItem(Student(position, false));
            },
          )),
        ],
      ),
    );
  }
}
