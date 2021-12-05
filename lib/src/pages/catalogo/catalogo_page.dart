import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:proyectofinalventasmovil/src/config/constants.dart';
import 'package:provider/provider.dart';
import 'package:proyectofinalventasmovil/src/models/producto.dart';
import 'package:proyectofinalventasmovil/src/pages/carrito/carrito_controller.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

import 'catalogo_controller.dart';

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({key}) : super(key: key);

  // CatalogoPage({Key? key, required this.title}) : super(key: key);
  // final String title;

  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  CatalogoController catalogo = CatalogoController();

  @override
  // ignore: must_call_super
  void initState() {
    // getConsultas();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: getProductos,
          child: FutureBuilder(
            builder: (context, AsyncSnapshot<dynamic> projectSnap) {
              if (projectSnap.connectionState == ConnectionState.none &&
                  projectSnap.hasData == null &&
                  projectSnap.data == null) {
                return Container();
              }
              if (projectSnap.data != null) {
                List response = projectSnap.data["message"];
                // print("response cantidad --> ${response.length}");
                if (response != null) {
                  return ListView(
                    children: [
                      _filtros(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 200.0),
                        child: Container(
                          height: 650,
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: response.length,
                            itemBuilder: (BuildContext context, int index) {
                              Producto producto = Producto(
                                  int.parse(
                                      "${response[index]["id_producto"]}"),
                                  response[index]["nombre"],
                                  double.parse("${response[index]["precio"]}"),
                                  response[index]["stock_total"],
                                  response[index]["color"],
                                  int.parse(
                                      "${response[index]["id_categoria"]}"),
                                  response[index]["categoria"],
                                  int.parse("${response[index]["id_marca"]}"),
                                  response[index]["marca"],
                                  response[index]["descripcion"],
                                  response[index]["imagenes_producto"],
                                  response[index]["detalle_stock"]);
                              return _cardTipo1(producto);
                            },
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(2, 3.5),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      )
                    ],
                  );
                } else {
                  // return CircularProgressIndicator();
                  return Container(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50.0,
                            width: 50.0,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              } else {
                // return CircularProgressIndicator();
                return Container(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 50.0,
                          width: 50.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.transparent,
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
            future: getProductos(),
          ),
        ),
      ),
    );
  }

  getConsultas() {
    catalogo.getProducts().then((value) => {print("value --> ${value}")});
  }

  Future getProductos() {
    return catalogo.getProducts();
  }

  Widget imagenProducto(Producto product) {
    print("product.imagenes_producto --> ${product.imagenes_producto}");
    return Container(
      height: 220,
      child: InkWell(
          // child: image_text(data),
          child: FadeInImage(
            image: NetworkImage(product.imagenes_producto[0]["ruta"]),
            placeholder: AssetImage('assets/img/jar-loading.gif'),
            fadeInDuration: Duration(milliseconds: 200),
            height: 160.0,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              'detailProduct',
              arguments: product,
            );
          }),
    );
  }

  Widget nombreProducto(Producto product) {
    return Container(
        height: 50,
        child: Center(
            child: Text(
          product.nombre,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          softWrap: true,
        )));
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

  Widget botonAgregar(Producto product) {
    var cart = Provider.of<CarritoController>(context);
    return FlatButton(
      textColor: Colors.red, // foreground
      onPressed: () {
        cart.add(product);
      },
      child: Text('Agregar a carrito'),
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

  Widget _cardTipo1(Producto product) {
    return Card(
      elevation: 10.0,
      child: Column(
        children: <Widget>[
          imagenProducto(product),
          nombreProducto(product),
          precioProducto(product),
          puntuacion()
          // botonAgregar(product)
        ],
      ),
    );
  }

  Widget _filtros() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(
            Icons.filter_alt,
            color: Colors.amber[400],
            size: 30,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
