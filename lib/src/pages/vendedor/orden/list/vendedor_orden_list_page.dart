import 'package:flutter/material.dart';

class VendedorOrdenListPage extends StatefulWidget {
  const VendedorOrdenListPage({Key key}) : super(key: key);

  @override
  _VendedorOrdenListPageState createState() => _VendedorOrdenListPageState();
}

class _VendedorOrdenListPageState extends State<VendedorOrdenListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Lista del Vendedor'),
      ),
    );
  }
}
