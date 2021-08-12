import 'package:mutendance/core/storage.dart';

class Student {
  final int roll;
  final Storage _storage;
  Student(this.roll, this._storage);

  bool get isPresent => Storage.attendance.isNotEmpty
      ? Storage.attendance[roll - _storage.rollLBound]
      : false;
  set isPresent(bool value) =>
      Storage.attendance[roll - _storage.rollLBound] = value;
}
