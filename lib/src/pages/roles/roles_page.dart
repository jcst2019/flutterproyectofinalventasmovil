import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/models/rol.dart';
import 'package:proyectofinalventasmovil/src/pages/roles/roles_controller_page.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class RolesPage extends StatefulWidget {
  const RolesPage({Key key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController _rolesController = new RolesController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _rolesController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selecciona un Rol'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: ListView(
          children: _rolesController.user != null
              ? _rolesController.user.roles.map((Rol rol) {
                  return _cardRol(rol);
                }).toList()
              : []
          //children: _rolesController.user != null ? _rolesController.user.roles.map((e) => null)
          ),
    );
  }

  Widget _cardRol(Rol rol) {
    return GestureDetector(
      onTap: (){
        _rolesController.gotoPage(rol.route);
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.14),
            height: 100,
            child: FadeInImage(
              image: rol.image != null
                  ? NetworkImage(rol.image)
                  : AssetImage('assets/no-image.png'),
              fit: BoxFit.contain, //Para que la imagen se vea mejor
              fadeInDuration: Duration(milliseconds: 50),
              placeholder: AssetImage('assets/no-image.png'),
            ),
          ),
          SizedBox(height: 15),
          Text(
            rol.name ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  void refresh(){
    setState(() {
    });//Refrescar la Pantalla
  }
}
