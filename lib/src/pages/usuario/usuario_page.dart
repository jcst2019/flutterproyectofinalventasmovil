import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyectofinalventasmovil/src/config/constants.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class UsuarioPage extends StatefulWidget {
  @override
  _UsuarioPage createState() => _UsuarioPage();
}

class _UsuarioPage extends State<UsuarioPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  // var storageService = locator<LocalStorageService>();
  //  var controllerCatalog = CatalogController();
  String fecha_creacion = "";
  // var controller_fb = FacebookController();

  @override
  // ignore: must_call_super
  void initState() {
    _consultas();
  }

  _consultas() {
    var user = _getString("correo:");
    print("user ${user}");
  }

  @override
  Widget build(BuildContext context) {
    var fecfecha = DateFormat().add_jm().format(DateTime.now());
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Colors.black,
          backgroundColor: MyColors.primaryColor,
          title: Text(Constants.appName,
              style: TextStyle(fontFamily: "Pacifico", fontSize: 30.00)),
          actions: <Widget>[],
          centerTitle: true,
        ), //   floatingActionButton: _buildFloatingActionButton(context),
        body: RefreshIndicator(
            child: ListView(
              children: <Widget>[
                SizedBox(height: 10.0),
                // Image.asset(
                //   "assets/gorro.png",
                //   width: 130,
                //   height: 130,
                // ),
                SizedBox(height: 10.0),
                Text(
                  '${_getString("nombres:")}${_getString("apellidos:")}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontFamily: "Pacifico",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //Divider(),
                SizedBox(height: 10.0),
                Text(
                  'Te uniste el ${fecha_creacion}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.0),
                Divider(
                  color: Colors.red,
                  height: 25.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 3.0,
                ),
                Text(
                  'Últimos pedidos realizados',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Ultima Actualizacion ${fecfecha}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Divider(
                  color: Colors.red,
                  height: 25.0,
                  indent: 20.0,
                  endIndent: 20.0,
                  thickness: 3.0,
                ),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: _listPedidos(),
                ),
              ],
            ),
            onRefresh: consultarEstado),
      ),
    );
  }

  List<Widget> _listPedidos() {
    List<Widget> widgets = [];
    /*var response = cart.getPedidos();
    print("response ${response}");
    if(response!=null){
      if (response.length > 0) {
        var ordenes_pedido = response;
        for (int i = 0; i < ordenes_pedido.length; i++) {
          var orden = ordenes_pedido[i];
          widgets.add(
            Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(left:25.0),
                          child: Text('Pedido Nº ${orden["id_orden"]}',
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:25.0),
                        child: Text('Realizado el ${_formatFecha(orden["fecha"])}'),
                        
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:25.0),
                        child: Text('Importe del pedido:   S/. ${orden["total_orden"]}'),
                      ),
                      Divider(
                        //color: Colors.black,
                        color:Colors.red,
                        height: 25.0,
                        indent: 20.0,
                        endIndent: 20.0,
                        //thickness: 1.0
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: _setIcon("${orden["estado"]}"),
                )
              ],
            )
          );
        }
      }
    }*/

    return widgets;
  }

  String _getString(String value) {
    /*var data = storageService.getFromDisk().split("person");
    var data1 = data[1].split(value);
    var data2 = data1[1].split(", ");
    return data2[0].toString();*/
    return "";
  }

  Widget _setIcon(String estado) {
    if (estado == '1')
      return Column(
        children: <Widget>[
          Icon(Icons.access_time, color: Colors.red),
          Text(
            "En espera",
            style: TextStyle(
              color: Colors.black,
            ),
          )
        ],
      );
    if (estado == '2')
      return Column(
        children: <Widget>[
          Icon(
            Icons.restaurant,
            color: Colors.deepOrange,
          ),
          Text("Preparando")
        ],
      );
    if (estado == '3')
      return Column(
        children: <Widget>[
          Icon(
            Icons.motorcycle,
            color: Colors.amber,
          ),
          Text("Enviado")
        ],
      );
    if (estado == '4')
      return Column(
        children: <Widget>[
          Icon(
            Icons.check_circle,
            color: Colors.green,
          ),
          Text("Recibido")
        ],
      );
    return Text("");
  }

  Future<Null> consultarEstado() async {
    _consultas();
  }
}
