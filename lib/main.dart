import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/pages/almacenero/categories/create/almacenero_categories_create_page.dart';
import 'package:proyectofinalventasmovil/src/pages/almacenero/orden/list/almacenero_orden_list_page.dart';
import 'package:proyectofinalventasmovil/src/pages/carrito/carrito_controller.dart';
import 'package:proyectofinalventasmovil/src/pages/carrito/carrito_page.dart';
import 'package:proyectofinalventasmovil/src/pages/client/products/list/client_products_list_page.dart';
import 'package:proyectofinalventasmovil/src/pages/client/update/client_update_page.dart';
import 'package:proyectofinalventasmovil/src/pages/detalleProducto/detalle_product_page.dart';
import 'package:proyectofinalventasmovil/src/pages/login/login_controller.dart';
import 'package:proyectofinalventasmovil/src/pages/login/login_page.dart';
import 'package:proyectofinalventasmovil/src/pages/register/register_page.dart';
import 'package:proyectofinalventasmovil/src/pages/roles/roles_page.dart';
import 'package:proyectofinalventasmovil/src/pages/vendedor/orden/list/vendedor_orden_list_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:proyectofinalventasmovil/src/service_locator.dart';
import 'package:provider/provider.dart' as multi;
import 'package:proyectofinalventasmovil/src/provider/provider.dart';


Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(MyApp());
  } catch (error) {
    print(error);
    print('Locator setup has failed');
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRECOTEX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var route = 'login';
    return Provider(
      child: multi.MultiProvider(
        providers: [
          multi.ChangeNotifierProvider(
            create: (_) => CarritoController(),
            child: CarritoPage(),
          ),
        ],
        child: MaterialApp(
          //title: 'Shopper',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'), // English
            const Locale('es'), // Español
          ],
          initialRoute: route,
          routes: {
            'login': (BuildContext context) => loginPage(),
            'register': (BuildContext context) => RegisterPage(),
            'roles': (BuildContext context) => RolesPage(),
            'client/products/list': (BuildContext context) => ClientsProductsListPage(),
            'client/update/': (BuildContext context) => ClientUpdatePage(),
            'almacenero/orden/list': (BuildContext context) => AlmaceneroOrdenListPage(),
            'almacenero/categories/create': (BuildContext context) => AlmaceneroCategoriesCreatePage(),
            'vendedor/orden/list': (BuildContext context) => VendedorOrdenListPage(),
            'detailProduct': (BuildContext context) => DetalleProductoPage(),
            'carrito': (BuildContext context) => CarritoPage(),
          },
        ),
      ),
    );
  }
}
