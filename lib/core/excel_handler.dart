import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';

const sheetName = 'attendance.xlsx';

/// Creates a new sheet in the device to store attendance info.
Future<bool> createSheet() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  // Check if sheet already exists.
  if (File('$appDocDir/$sheetName').existsSync()) {
    return false;
  }
  // Create a sheet with Roll. No. as a field.
  final excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];
  final cell = sheetObject.cell(CellIndex.indexByString("A1"));
  cell.value = "Roll No.";
  final fileBytes = excel.save();
  if (fileBytes != null) {
    File("$appDocDir/$sheetName")
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
    return true;
  }

  return false;
}

Future<Excel> _openSheet() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  if (!File('$appDocDir/$sheetName').existsSync()) {
    if (!await createSheet()) {
      throw Exception('IOException: Failed to create sheet.');
    }
  }
  return Excel.decodeBytes(File('$appDocDir/$sheetName').readAsBytesSync());
}

/// Obtains students data excel sheet from storage.
Future<Sheet> getStudentsData() async {
  final excel = await _openSheet();
  final sheet = excel['Sheet1'];
  return sheet;
}

/// Generates student roll numbers based on lower and higher limits
/// and saved them to the sheet.
Future<void> saveStudents(int lower, int higher) async {
  final appDocDir = await getApplicationDocumentsDirectory();
  final excel = await _openSheet();
  final sheet = excel['Sheet1'];
  // Populate the sheet with this roll no. range.
  for (var i = lower; i <= higher; i++) {
    sheet.cell(CellIndex.indexByString('A${i - lower + 1}')).value = i;
  }
  final fileBytes = excel.save();
  if (fileBytes != null) {
    File("$appDocDir/$sheetName")
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes);
  }
}

/// Obtain roll numbers list.
List<String> getStudentRoll(Sheet sheet) {
  return List.generate(sheet.maxCols, (index) {
    final cell =
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: index));
    return cell.value.toString();
  });
}
