import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:proyectofinalventasmovil/src/utils/shared_pref.dart';

class AlmaceneroOrdenListController {
  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Function refresh;
  User user;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    user = User.fromJson(await _sharedPref.read('user'));
    this.refresh = refresh;
    refresh();
  }

  void logout() {
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToCategoriesCreate() {
    Navigator.pushNamed(context, 'almacenero/categories/create');
  }
}
