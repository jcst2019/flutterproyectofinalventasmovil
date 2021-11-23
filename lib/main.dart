import 'package:flutter/material.dart';
import 'package:proyectofinalventasmovil/src/pages/client/products/list/client_products_list_page.dart';
import 'package:proyectofinalventasmovil/src/pages/login/login_page.dart';
import 'package:proyectofinalventasmovil/src/pages/register/register_page.dart';
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
               'client/products/list': (BuildContext context) => ClientsProductsListPage()
      },
      theme: ThemeData(
          primaryColor: MyColors.primaryColor
      ),
    );
  }
}