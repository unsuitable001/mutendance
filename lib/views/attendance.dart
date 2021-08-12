import 'package:flutter/material.dart';
import 'package:mutendance/core/storage.dart';
import 'package:mutendance/model/student.dart';
import 'package:mutendance/views/components/student.dart';

class AttendancePage extends StatefulWidget {
  final Storage storage;
  const AttendancePage(this.storage);
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
            onChanged: (value) =>
                widget.storage.setAbsentsOnly(value).then((value) => {
                      this.setState(() {}),
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('You will now mark '
                              '${widget.storage.isAbsentsOnly ? "absent" : "present"}'
                              ' students only.')))
                    }),
            value: widget.storage.isAbsentsOnly,
          ),
          Expanded(
              child: ListView.builder(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            itemCount: widget.storage.rollRBound - widget.storage.rollLBound,
            itemBuilder: (context, position) {
              return StudentListItem(
                  Student(position, widget.storage.isAbsentsOnly),
                  widget.storage);
            },
          )),
        ],
      ),
    );
  }
}
