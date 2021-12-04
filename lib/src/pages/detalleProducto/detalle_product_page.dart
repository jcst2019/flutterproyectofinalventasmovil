import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:proyectofinalventasmovil/src/config/constants.dart';
import 'package:proyectofinalventasmovil/src/models/producto.dart';
import 'package:proyectofinalventasmovil/src/pages/carrito/carrito_controller.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class DetalleProductoPage extends StatefulWidget {
  /*DetailProduct({Key? key, required this.title}) : super(key: key);
  final String title;*/

  @override
  _DetalleProductoPageState createState() => _DetalleProductoPageState();
}

class _DetalleProductoPageState extends State<DetalleProductoPage> {
  Producto product;
  int _currentIndex = 0;

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      print("list[i] --> ${list[i]}");
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      product = ModalRoute.of(context).settings.arguments as Producto;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(Constants.appName,
            style: TextStyle(fontFamily: "Pacifico", fontSize: 30.00)),
        actions: <Widget>[
          Consumer<CarritoController>(
            builder: (context, cart, child) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Badge(
                        badgeColor: Colors.black87,
                        toAnimate: true,
                        badgeContent: Text(
                          '${cart.getNumber()}',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        child: Icon(
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
      body: Center(
        child: Card(
          elevation: 10.0,
          child: ListView(
            children: <Widget>[
              imagenProducto(),
              nombreProducto(),
              botonAgregar(),
              puntuacion(),
              caracteristicas()
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget imagenProducto() {
    return Container(
      height: 500,
      child: InkWell(
          // child: image_text(data),
          child: FadeInImage(
            image: NetworkImage(
                'https://static.photocdn.pt/images/articles/2017_1/iStock-545347988.jpg'),
            placeholder: AssetImage('assets/img/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 500.0,
            fit: BoxFit.cover,
          ),
          onTap: () {}),
    );
  }

  Widget nombreProducto() {
    return Container(
        child: Center(
            child: Text(
      this.product.nombre,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      softWrap: true,
    )));
  }

  Widget botonAgregar() {
    var cart = Provider.of<CarritoController>(context);
    return Padding(
        padding: const EdgeInsets.only(
            left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
        child: Row(
          children: [
            Expanded(
                child: IconButton(
              icon: Icon(Icons.minimize),
              tooltip: 'Quitar del carrito',
              onPressed: () {
                cart.remove(this.product);
              },
            )),
            Expanded(
              child: Text(
                "${cart.count(product.id_producto)}",
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.add),
                tooltip: 'Agregar a carrito',
                onPressed: () {
                  cart.add(product);
                },
              ),
            ),
            Expanded(flex: 1, child: Text("")),
            Expanded(flex: 2, child: precioProducto(product))
          ],
        ));
    /*return FlatButton(
      textColor: Colors.red, // foreground
      onPressed: () {
        cart.add(this.product);
      },
      child: Text('Agregar a carrito'),
    );*/
  }

  Widget precioProducto(Producto product) {
    return Container(
        height: 30,
        child: Center(
            child: Text(
          "S/. ${product.precio}",
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
          ),
          softWrap: true,
        )));
  }

  Widget caracteristicas() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Caracteristicas: ",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [Expanded(child: Text(product.descripcion))],
              )),
          Row(
            children: [
              Expanded(
                  child: Text("Categoria:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(child: Text(product.categoria))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text("Marca:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(child: Text(product.marca))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text("Color:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12))),
              Expanded(child: Text(product.color))
            ],
          ),
        ],
      ),
    );
  }

  Widget puntuacion() {
    return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Icon(
            Icons.star,
            color: Colors.amber[400],
          ),
          Icon(
            Icons.star,
            color: Colors.amber[400],
          ),
          Icon(
            Icons.star_half_outlined,
            color: Colors.amber[400],
          ),
          Icon(
            Icons.star_outline_outlined,
            color: Colors.blueGrey[100],
          ),
          Icon(
            Icons.star_outline_outlined,
            color: Colors.blueGrey[100],
          )
        ]));
  }
}
