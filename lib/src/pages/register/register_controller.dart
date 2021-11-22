import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:proyectofinalventasmovil/src/models/response_api.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:proyectofinalventasmovil/src/provider/users_prrovider.dart';

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


    User user = new User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        password: password);


    ResponseApi responseApi = await usersProvider.create(user);

    print('Respuesta: ${responseApi.toJson()}');
    print('Email: $email');
    print('Nombre: $name');
    print('Apellido : $lastName');
    print('Teléfono : $phone');
    print('Contraseña : $password');
    print('Confirmar Contraseña : $name');
  }
}
