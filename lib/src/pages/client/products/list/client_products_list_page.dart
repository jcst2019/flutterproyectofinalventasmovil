import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/pages/client/products/list/client_products_list_controller.dart';

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
      _controller.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
        onLongPress: _controller.logout,
        child: Text('Cerrar sesión'),
      ),
    ));
  }
}
