import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectofinalventasmovil/src/models/response_api.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:proyectofinalventasmovil/src/provider/users_prrovider.dart';
import 'package:proyectofinalventasmovil/src/utils/my_snackbar.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RegisterController {
  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;
  ProgressDialog _progressDialog;
  bool isEnable = true;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
    usersProvider.init(context);
    _progressDialog = ProgressDialog(context: context);
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
      MySnackbar.show(context, 'Las contrase??as no coinciden...');
      return;
    }
    if (password.length < 6) {
      MySnackbar.show(context, 'La contrase??a debe de tener 6 caracteres...');
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context, 'Por favor seleccione una imagen...');
      return;
    }
    isEnable = false;
    _progressDialog.show(max: 100, msg: 'Espere un momento');

    User user = new User(
        email: email,
        name: name,
        lastname: lastName,
        phone: phone,
        password: password);

    Stream stream = await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {
      _progressDialog.close();

      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');
      print('Email: $email');
      print('Nombre: $name');
      print('Apellido : $lastName');
      print('Tel??fono : $phone');
      print('Contrase??a : $password');
      print('Confirmar Contrase??a : $name');
      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, 'login');
        });
      }else{
        isEnable = true;
      }
    });
  }

  void back() {
    Navigator.pop(context);
  }

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().getImage(source: imageSource);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.pop(context);
    refresh();
  }

  void ShowAlertDialog() {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.gallery);
        },
        child: Text('Galer??a'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('C??mara'));

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona tu imagen'),
      actions: [galleryButton, cameraButton],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
