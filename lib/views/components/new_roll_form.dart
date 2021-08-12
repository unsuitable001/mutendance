import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutendance/core/storage.dart';

Future showRollForm(BuildContext context) async {
  final fromTextController =
      TextEditingController.fromValue(TextEditingValue(text: '0'));
  final toTextController =
      TextEditingController.fromValue(TextEditingValue(text: '100'));
  final storage = await Storage.getInstance();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Roll Numbers'),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'From',
                    helperText: 'From Roll'),
                controller: fromTextController,
              ),
              const Divider(
                color: Colors.transparent,
              ),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'To',
                    helperText: 'To Roll'),
                controller: toTextController,
              ),
            ],
          ),
          actions: [
            MaterialButton(
                child: Text('Save'),
                onPressed: () async {
                  await storage.setRollRange(int.parse(fromTextController.text),
                      int.parse(toTextController.text));
                  Navigator.of(context).pop();
                })
          ],
        );
      });
}
