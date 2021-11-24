import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:proyectofinalventasmovil/src/models/response_api.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:proyectofinalventasmovil/src/provider/users_prrovider.dart';
import 'package:proyectofinalventasmovil/src/utils/my_snackbar.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Future init(BuildContext context) {
    this.context = context;
    usersProvider.init(context);
  }

  Future<void> register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        lastName.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos...');
      return;
    }
    if (confirmPassword != password) {
      MySnackbar.show(context, 'Las contraseñas no coinciden...');
      return;
    }
    if (password.length < 6) {
      MySnackbar.show(context, 'La contraseña debe de tener 6 caracteres...');
      return;
    }

    User user = new User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        password: password);

    ResponseApi responseApi = await usersProvider.create(user);

    MySnackbar.show(context, responseApi.message);

    if(responseApi.success){
      Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, 'login');
      });
    }

    print('Respuesta: ${responseApi.toJson()}');
    print('Email: $email');
    print('Nombre: $name');
    print('Apellido : $lastName');
    print('Teléfono : $phone');
    print('Contraseña : $password');
    print('Confirmar Contraseña : $name');
  }

  void back(){
    Navigator.pop(context);
  }
}
