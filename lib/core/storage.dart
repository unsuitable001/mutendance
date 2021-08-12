import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static final _storage = Storage._internal();
  static SharedPreferences? _sharedPreferences;

  /// Loads data from [SharedPreferences] and provides an unified API over it.
  static Future<Storage> getInstance() async {
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _storage;
  }

  Future<bool> setRollRange(int lbound, int rbound) async {
    if (lbound > rbound) throw ArgumentError.value(rbound, 'lbound > rbound');
    if (_sharedPreferences == null) {
      await getInstance();
    }
    return await _sharedPreferences!.setInt('rollLBound', lbound) &&
        await _sharedPreferences!.setInt('rollRBound', rbound);
  }

  Future<bool> setAbsentsOnly(bool isAbsentsOnly) {
    return _sharedPreferences!.setBool('absentsOnly', isAbsentsOnly);
  }

  int get rollLBound => _sharedPreferences?.getInt('rollLBound') ?? 0;
  int get rollRBound => _sharedPreferences?.getInt('rollRBound') ?? 0;
  bool get isAbsentsOnly => _sharedPreferences?.getBool('absentsOnly') ?? true;

  Storage._internal();
}
