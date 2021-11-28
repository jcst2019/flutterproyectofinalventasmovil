import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectofinalventasmovil/src/models/response_api.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:proyectofinalventasmovil/src/provider/users_prrovider.dart';
import 'package:proyectofinalventasmovil/src/utils/my_snackbar.dart';
import 'package:proyectofinalventasmovil/src/utils/shared_pref.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  BuildContext context;
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  PickedFile pickedFile;
  File imageFile;
  Function refresh;
  ProgressDialog _progressDialog;
  bool isEnable = true;
  User user;
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = ProgressDialog(context: context);
    user = User.fromJson(await _sharedPref.read('user'));
    usersProvider.init(context, sessionUser: user);
    nameController.text = user.name;
    lastNameController.text = user.lastname;
    phoneController.text = user.phone;
    refresh();
  }

  Future<void> update() async {
    String name = nameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || lastName.isEmpty || phone.isEmpty) {
      MySnackbar.show(context, 'Debes ingresar todos los campos...');
      return;
    }
    //if (imageFile == null) {
    //  MySnackbar.show(context, 'Por favor seleccione una imagen...');
    //  return;
    //}
    isEnable = false;
    _progressDialog.show(max: 100, msg: 'Espere un momento');

    User myuser = new User(
        id: user.id,
        name: name,
        lastname: lastName,
        phone: phone,
        image: user.image);

    Stream stream = await usersProvider.update(myuser, imageFile);
    stream.listen((res) async {
      _progressDialog.close();

      //ResponseApi responseApi = await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
      print('Respuesta: ${responseApi.toJson()}');
      print('Nombre: $name');
      print('Apellido : $lastName');
      print('Teléfono : $phone');
      print('Confirmar Contraseña : $name');
      //MySnackbar.show(context, responseApi.message);
      Fluttertoast.showToast(msg: responseApi.message);
      if (responseApi.success) {
        user = await usersProvider
            .getById(myuser.id); //Obteniendo el usuario de la BD
        print('Usuario obtenido: ${user.toJson()}');
        _sharedPref.save('user', user.toJson());
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context, 'client/products/list', (route) => false);
        });
      } else {
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
        child: Text('Galería'));
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          selectImage(ImageSource.camera);
        },
        child: Text('Cámara'));

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
