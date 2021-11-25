import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/pages/register/register_controller.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _controllerRegister = new RegisterController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controllerRegister.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity, //Centrar la imagen
      child: Stack(
        children: [
          Positioned(top: 0, left: 0, child: _rectangleRegistro()),
          Positioned(
            child: _textRegister(),
            top: 20,
            left: 100,
          ),
          Container(
            width: double.maxFinite, //Centrado
            margin: EdgeInsets.only(top: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _imageUser(),
                  SizedBox(
                    height: 10,
                  ),
                  //_imageBanner(),
                  //_lottieAnimation(),
                  _textFieldEmail(),
                  _textFieldName(),
                  _textFieldLastName(),
                  _textFieldPhone(),
                  _textFielPassword(),
                  _textFielConfirmPassword(),
                  _buttonRegister()
                  //_textDontHaveAccount()
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _rectangleRegistro() {
    return Container(
      width: 500,
      height: 80,
      decoration: BoxDecoration(color: MyColors.primaryColor),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controllerRegister.emailController,
        keyboardType: TextInputType
            .emailAddress, //Para que se muestre el teclado donde se muestre el arroba @
        decoration: InputDecoration(
            hintText: 'Correo Electrónico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(Icons.email, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controllerRegister.nameController,
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
        controller: _controllerRegister.lastNameController,
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
        controller: _controllerRegister.phoneController,
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

  Widget _textFielPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controllerRegister.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(Icons.lock, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _textFielConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controllerRegister.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confimar Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(Icons.phone, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _controllerRegister.register,
        child: Text('Registrarse'),
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
            onPressed: _controllerRegister.back,
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
      onTap: _controllerRegister.ShowAlertDialog,
      child: CircleAvatar(
        backgroundImage: _controllerRegister.imageFile != null
            ? FileImage(_controllerRegister.imageFile)
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
