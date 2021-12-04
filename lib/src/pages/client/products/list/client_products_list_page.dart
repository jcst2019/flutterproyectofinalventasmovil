import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:proyectofinalventasmovil/src/config/constants.dart';
import 'package:proyectofinalventasmovil/src/pages/carrito/carrito_controller.dart';
import 'package:proyectofinalventasmovil/src/pages/catalogo/catalogo_page.dart';
import 'package:proyectofinalventasmovil/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class ClientsProductsListPage extends StatefulWidget {
  const ClientsProductsListPage({Key key}) : super(key: key);

  @override
  _ClientsProductsListPageState createState() =>
      _ClientsProductsListPageState();
}

class _ClientsProductsListPageState extends State<ClientsProductsListPage> {
  ClientProductsListController _controller = new ClientProductsListController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _controller.key,
        appBar: AppBar(
          //title: _menuDrawer() ,
          leading: _menuDrawer(),
          backgroundColor: MyColors.primaryColor,
          title: Text(Constants.appName,
              style: const TextStyle(fontFamily: "Pacifico", fontSize: 30.00,)),
          actions: <Widget>[
            Consumer<CarritoController>(
              builder: (context, carrito, child) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        icon: Badge(
                          badgeColor: Colors.black87,
                          toAnimate: true,
                          badgeContent: Text(
                            '${carrito.getNumber()}',
                            style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          child: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            'carrito'
                          );
                        },
                      ),
                    ],
                  )),
            )
          ],
          centerTitle: true,
        ),
        drawer: _drawer(),
        body: CatalogoPage()
    );
        /*Center(
          child: ElevatedButton(
            onLongPress: _controller.logout,
            child: Text('Cerrar sesión'),
          ),
        ));
         */
  }

  Widget _menuDrawer() {
    //return IconButton(onPressed: () {}, icon: Icon(Icons.menu));
    return GestureDetector(
        onTap: _controller.openDrawer,
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
                    '${_controller.user?.name ?? ''} ${_controller.user?.lastname ?? ''}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                  Text(
                    _controller.user?.email ?? '',
                    style: TextStyle(
                        fontSize: 13,
                        color:
                            Colors.grey[200], // de 100 a 900 es la intensidad
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    _controller.user?.phone ?? '',
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
                      image: _controller.user?.image != null
                          ? NetworkImage(_controller.user?.image)
                          : AssetImage('assets/img/no-image.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  )
                ],
              )),
          ListTile(
            onTap: _controller.gotoUpdatePage,
            title: Text('Editar Perfil'),
            trailing: Icon(Icons.edit_outlined),
            //leading:Icon(Icons.cancel) , //Parte Isquierda
          ),
          ListTile(
            title: Text('Mis Pedidos'),
            trailing: Icon(Icons.shopping_cart_outlined),
            //leading:Icon(Icons.cancel) , //Parte Isquierda
          ),
          _controller != null
              ? _controller.user.roles.length > 1
                  ? ListTile(
                      onTap: _controller.goToRoles,
                      title: Text('Seleccionar Rol'),
                      trailing: Icon(Icons.person_outlined),
                      //leading:Icon(Icons.cancel) , //Parte Isquierda
                    )
                  : Container()
              : Container(),
          ListTile(
            onTap: _controller.logout,
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
