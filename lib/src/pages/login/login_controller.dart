import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinalventasmovil/src/models/response_api.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:proyectofinalventasmovil/src/provider/users_prrovider.dart';
import 'package:proyectofinalventasmovil/src/utils/my_snackbar.dart';
import 'package:proyectofinalventasmovil/src/utils/shared_pref.dart';

class LoginController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  SharedPref _sharedPref = new SharedPref(); //_ Es privado por eso se coloca _

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.init(context);
    /*
    User user = User.fromJson(await _sharedPref.read('user') ??
        {}); //En el caso este vacío se envía {}
    print('Usuario:${user.toJson()}');
    if (user?.sessionToken != null) {
      //user? es equivalente a user != null
      Navigator.pushNamedAndRemoveUntil(
          context, 'client/products/list', (route) => false);
    }*/
  }

  void goToRegistrerPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);
    print('Respuesta Object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');
    print('Email: $email');
    print('Password : $password');

    if (responseApi.success) {
      User user = User.fromJson(responseApi.data);
      _sharedPref.save('user', user.toJson());
      Navigator.pushNamedAndRemoveUntil(
          context,
          'client/products/list',
          (route) =>
              false); //Nos lleva  al pantalla pero destruye todas las anteriores impidiendo que regresemos a la anterior

    } else {
      MySnackbar.show(context, responseApi.message);
    }

    MySnackbar.show(context, responseApi.message);
  }
}
