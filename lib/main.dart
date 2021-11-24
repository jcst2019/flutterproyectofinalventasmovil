import 'package:flutter/material.dart';
import 'package:proyectofinalventasmovil/src/pages/almacenero/orden/list/almacenero_orden_list_page.dart';
import 'package:proyectofinalventasmovil/src/pages/client/products/list/client_products_list_page.dart';
import 'package:proyectofinalventasmovil/src/pages/login/login_page.dart';
import 'package:proyectofinalventasmovil/src/pages/register/register_page.dart';
import 'package:proyectofinalventasmovil/src/pages/roles/roles_page.dart';
import 'package:proyectofinalventasmovil/src/pages/vendedor/orden/list/vendedor_orden_list_page.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Flutter',
      debugShowCheckedModeBanner:
      false, //Quitar la etiqueta de Debug en el Emulador
      initialRoute: 'login',
      routes: {'login': (BuildContext context) => loginPage(),
               'register': (BuildContext context) => RegisterPage(),
               'roles': (BuildContext context) => RolesPage(),
               'client/products/list': (BuildContext context) => ClientsProductsListPage(),
               'almacenero/orden/list': (BuildContext context) => AlmaceneroOrdenListPage(),
               'vendedor/orden/list': (BuildContext context) => VendedorOrdenListPage()
      },
      theme: ThemeData(
          primaryColor: MyColors.primaryColor
      ),
    );
  }
}