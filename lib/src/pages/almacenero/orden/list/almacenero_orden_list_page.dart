import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/pages/almacenero/orden/list/almacenero_orden_list_controller.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class AlmaceneroOrdenListPage extends StatefulWidget {
  const AlmaceneroOrdenListPage({Key key}) : super(key: key);

  @override
  _AlmaceneroOrdenListPageState createState() =>
      _AlmaceneroOrdenListPageState();
}

class _AlmaceneroOrdenListPageState extends State<AlmaceneroOrdenListPage> {

  AlmaceneroOrdenListController _almaceneroOrdenListController = new AlmaceneroOrdenListController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _almaceneroOrdenListController.init(context,refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _almaceneroOrdenListController.key,
      drawer: _drawer(),
      appBar: AppBar(
          leading: _menuDrawer(),
          backgroundColor: MyColors.primaryColor
      ),
      body: Center(
        child: Text('Lista del Almacenero'),
      ),
    );
  }

  Widget _menuDrawer() {
    //return IconButton(onPressed: () {}, icon: Icon(Icons.menu));
    return GestureDetector(
        onTap: _almaceneroOrdenListController.openDrawer,
        child: Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/img/menu.png',
            width: 20,
            height: 20,
          ),
        ));
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(color: MyColors.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, //Psicionarlos en la parate izquierda de la pantalla
                children: [
                  Text(
                    '${_almaceneroOrdenListController.user?.name ?? ''} ${_almaceneroOrdenListController.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _almaceneroOrdenListController.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color:
                        Colors.grey[200], // de 100 a 900 es la intensidad
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _almaceneroOrdenListController.user?.phone ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color:
                        Colors.grey[200], // de 100 a 900 es la intensidad
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      image: _almaceneroOrdenListController.user?.image != null
                          ? NetworkImage(_almaceneroOrdenListController.user?.image)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
            //leading:Icon(Icons.cancel) , //Parte Isquierda
          ),
          ListTile(
            title: Text('Mis Pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
            //leading:Icon(Icons.cancel) , //Parte Isquierda
          ),
          _almaceneroOrdenListController != null
              ? _almaceneroOrdenListController.user.roles.length > 1
              ? ListTile(
            onTap: _almaceneroOrdenListController.goToRoles,
            title: Text('Seleccionar Rol'),
            trailing: Icon(Icons.person_outlined),
            //leading:Icon(Icons.cancel) , //Parte Isquierda
          )
              : Container()
              : Container(),
          ListTile(
            onTap: _almaceneroOrdenListController.logout,
            title: Text('Cerrar Sesión'),
            trailing: Icon(Icons.power_settings_new),
          )
        ],
      ),
    );
  }

  void refresh() {
    setState(
            () {}); //"Es como si icieramos Ctrl +'S', que sirve para refrescar la página"
  }
}
