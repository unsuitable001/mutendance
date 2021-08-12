import 'package:flutter/material.dart';
import 'package:mutendance/core/storage.dart';
import 'package:mutendance/views/components/new_roll_form.dart';
import 'records.dart';
import 'attendance.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Records',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
      body: FutureBuilder<Storage>(
          future: Storage.getInstance(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? IndexedStack(
                    children: <Widget>[
                      AttendancePage(snapshot.data!),
                      RecordsPage()
                    ],
                    index: _selectedIndex,
                  )
                : CircularProgressIndicator();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showRollForm(context).then((_) {
            this.setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('New roll number range added.')));
          });
        },
        tooltip: 'Add new students',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
