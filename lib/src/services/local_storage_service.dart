import 'dart:convert';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  /*static LocalStorageService _instance;
  static SharedPreferences _preferences;*/
  static var _instance;
  static var _preferences;

  static const String UserKey = 'user';

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  User get user {
    var userJson = _getFromDisk();
    if (userJson == null) {
      return User.isNull();
    }

    return User.fromJson(json.decode(userJson));
  }

  set user(User userToSave) {
    saveStringToDisk(json.encode(userToSave.toJson()));
  }

  dynamic _getFromDisk() {
    var value = _preferences.get(UserKey);
    //print('(TRACE) LocalStorageService:_getFromDisk. key: $UserKey value: $value');
    return value;
  }

  String getFromDisk() {
    String value = _preferences.getString(UserKey);
    //print('(TRACE) LocalStorageService: getFromDisk. key: $UserKey value: $value');
    return value;
  }

  void saveStringToDisk(String content) {
    //print('(TRACE) LocalStorageService:_saveStringToDisk. key: $UserKey value: $content');
    _preferences.setString(UserKey, content);
  }

  void removeToDisk() {
    //print('(TRACE) LocalStorageService:_removeToDisk. key: $UserKey');
    _preferences.remove(UserKey);
  }

  void _saveToDisk<T>(String key, T content) {
    //print('(TRACE) LocalStorageService:_saveToDisk. key: $key value: $content');

    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }
}
