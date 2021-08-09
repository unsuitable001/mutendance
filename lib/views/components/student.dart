import 'package:flutter/material.dart';
import 'package:mutendance/model/student.dart';

class StudentListItem extends StatefulWidget {
  final Student student;
  StudentListItem(this.student) : super(key: new ObjectKey(student));
  @override
  StudentListItemState createState() => StudentListItemState(student);
}

class StudentListItemState extends State<StudentListItem> {
  final Student student;
  StudentListItemState(this.student);
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
        title: Text(student.roll.toString()),
        value: student.isPresent,
        onChanged: (bool? value) {
          setState(() {
            student.isPresent = value;
          });
        });
  }
}
