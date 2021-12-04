import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:proyectofinalventasmovil/src/api/environment.dart';

class ApiService {
  String host = Enviroment.API_TEST;

  Future create(String route, Map data) async {
    Uri uri = Uri(host: host, path: route);
    var response = await http.post(uri, body: data);
    return jsonDecode(response.body);
  }

  Future send(String route, Map data) async {
    Uri uri = Uri(host: host, path: route);
    var response = await http.post(uri, body: data);
    return jsonDecode(response.body);
  }

  Future get(String route) async {
    // Uri uri=Uri(host: host,path: route);
    // var uri = host+"/"+route;
    // print("url --> " + host + route);
    var response = await http.get(Uri.parse(host + route));
    return jsonDecode(response.body);
  }

  Future update(String route, Map<String, dynamic> data) async {
    Uri uri = Uri(host: host, path: route);
    return await http.put(uri, body: data);
  }

  Future delete(String route) async {
    Uri uri = Uri(host: host, path: route);
    return await http.delete(uri);
  }
}
