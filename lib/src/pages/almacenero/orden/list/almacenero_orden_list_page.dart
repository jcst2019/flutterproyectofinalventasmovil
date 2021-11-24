import 'package:flutter/material.dart';

class AlmaceneroOrdenListPage extends StatefulWidget {
  const AlmaceneroOrdenListPage({Key key}) : super(key: key);

  @override
  _AlmaceneroOrdenListPageState createState() =>
      _AlmaceneroOrdenListPageState();
}

class _AlmaceneroOrdenListPageState extends State<AlmaceneroOrdenListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Lista del Almacenero'),
      ),
    );
  }
}
