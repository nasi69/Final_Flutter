import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'logged_user_model.dart';

final FlutterSecureStorage _storage = FlutterSecureStorage();
const _key = "TodoLogic";
final _defaultLoggedUser = LoggedUserModel(
  user: User(
    id: 0,
    name: "name",
    email: "email",
  ),
  token: "no_token",
);

class TodoLoginLogic extends ChangeNotifier {
  LoggedUserModel _loggedUser = _defaultLoggedUser;
  LoggedUserModel get loggedUser => _loggedUser;

  Future<LoggedUserModel> readLoggedUser() async {
    await Future.delayed(Duration(seconds: 1));
    String? value = await _storage.read(key: _key);

    if (value == null) {
      _loggedUser = _defaultLoggedUser;
    } else {
      _loggedUser = loggedUserModelFromJson(value);
    }
    notifyListeners();
    return _loggedUser;
  }

  Future saveLoggedUser(LoggedUserModel user) async{
    _loggedUser = user;
    await _storage.write(key: _key, value: loggedUserModelToJson(user));
    notifyListeners();
  }

  Future clearLoggedUser() async{
    await _storage.delete(key: _key);
    notifyListeners();
  }
}
