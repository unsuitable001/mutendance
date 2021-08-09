import 'package:flutter/material.dart';
import 'package:mutendance/core/excel_handler.dart';
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

  final _screens = <Widget>[AttendancePage(), RecordsPage()];

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
      body: FutureBuilder(
          future: getStudentsData(),
          builder: (context, snapshot) {
            return IndexedStack(
              children: _screens,
              index: _selectedIndex,
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => null,
        tooltip: 'Add new students',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
