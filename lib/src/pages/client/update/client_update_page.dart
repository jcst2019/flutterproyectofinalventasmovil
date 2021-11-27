import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/pages/client/update/client_update_controller.dart';
import 'package:proyectofinalventasmovil/src/pages/register/register_controller.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class ClientUpdatePage extends StatefulWidget {
  const ClientUpdatePage({Key key}) : super(key: key);

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  ClientUpdateController _clientUpdateController = new ClientUpdateController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _clientUpdateController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Editar Perfil'), backgroundColor: MyColors.primaryColor),
      body: Container(
        width: double.infinity, //Centrar la imagen
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              _imageUser(),
              SizedBox(
                height: 10,
              ),
              //_imageBanner(),
              //_lottieAnimation(),
              _textFieldName(),
              _textFieldLastName(),
              _textFieldPhone()
              //_textDontHaveAccount()
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonModificar(),
    );
  }

  Widget _rectangleRegistro() {
    return Container(
      width: 500,
      height: 80,
      decoration: BoxDecoration(color: MyColors.primaryColor),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _clientUpdateController.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre(s)',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(Icons.person, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _textFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _clientUpdateController.lastNameController,
        decoration: InputDecoration(
            hintText: 'Apellido(s)',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon:
                Icon(Icons.person_outline, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _textFieldPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _clientUpdateController.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
            hintText: 'Teléfono',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(Icons.phone, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _buttonModificar() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _clientUpdateController.isEnable
            ? _clientUpdateController.update
            : null, //Con la variable controllerRegister.isEnable determinado si se habilita el boton
        child: Text('ACTUALIZAR PERFIL'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _textRegister() {
    return Row(
      children: [
        IconButton(
            onPressed: _clientUpdateController.back,
            icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
        Text(
          'Nuevo Usuario',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ],
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _clientUpdateController.ShowAlertDialog,
      child: CircleAvatar(
        backgroundImage: _clientUpdateController.imageFile != null
            ? FileImage(_clientUpdateController.imageFile)
            : _clientUpdateController.user?.image != null
                ? NetworkImage(_clientUpdateController.user.image)
                : AssetImage('assets/img/user_profile_2.png'),
        radius: 60,
        backgroundColor: Colors.white,
      ),
    );
  }

  void refresh() {
    setState(
        () {}); //"Es como si icieramos Ctrl +'S', que sirve para refrescar la página"
  }
}
