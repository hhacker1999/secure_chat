import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocalDataService {
   late SharedPreferences _prefs;
  

  Future<void> create(String key, String map) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(key, map);
  }

  Future<String> read(String key) async {
    _prefs = await SharedPreferences.getInstance();
    var result = _prefs.getString(key);
    if (result != null)
      return result;
    else
      throw Exception();
  }

  Future<void> delete(String key) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(key);
  }

  Future<bool> containsKey(String key) async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.containsKey(key);
  }
}
