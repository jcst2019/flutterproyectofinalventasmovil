import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:proyectofinalventasmovil/src/api/environment.dart';
import 'package:proyectofinalventasmovil/src/models/producto.dart';
import 'package:proyectofinalventasmovil/src/services/api_service.dart';

class CatalogoController with ChangeNotifier {
  var service = ApiService();
  var host = Enviroment.API_TEST;
  var route = "producto";

  Future<List<Producto>> getProducts2() async {
    var response = await http.get(Uri.parse(host + route));
    List<Producto> products =
        jsonDecode(response.body).map((u) => Producto.fromJson(u)).toList();
    return products;
  }

  Future getProducts() {
    return service.get(route);
    // return ;
  }
}
