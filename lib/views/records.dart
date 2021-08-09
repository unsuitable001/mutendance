import 'package:flutter/material.dart';

class RecordsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Attendance Records',
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SingleChildScrollView(
            child: DataTable(columns: <DataColumn>[
              DataColumn(label: Text('Roll No.')),
              DataColumn(label: Text('09/09')),
            ], rows: <DataRow>[
              DataRow(cells: [DataCell(Text('101')), DataCell(Text('P'))])
            ]),
          ),
        ],
      ),
    );
  }
}
