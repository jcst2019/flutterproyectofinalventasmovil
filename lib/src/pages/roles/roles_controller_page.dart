import 'package:flutter/cupertino.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:proyectofinalventasmovil/src/utils/shared_pref.dart';

class RolesController {
  BuildContext context;
  Function refresh;
  User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    //Obteneiendo el usuario de Sesión
    user = User.fromJson(await sharedPref.read('user'));
    refresh();
  }

  void gotoPage(String ruta){
      Navigator.pushNamedAndRemoveUntil(context, ruta, (route) => false);
  }
}
