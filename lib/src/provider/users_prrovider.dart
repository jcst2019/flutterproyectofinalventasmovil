import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proyectofinalventasmovil/src/api/environment.dart';
import 'package:proyectofinalventasmovil/src/models/response_api.dart';
import 'package:proyectofinalventasmovil/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:proyectofinalventasmovil/src/utils/shared_pref.dart'; //Para que se pueda usar basename

class UsersProvider {
  String _url =
      Enviroment.API_VENTAS_MOVIL; // Se coloca _ porque es una variable privada
  String _api = '/api/users';

  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, {User sessionUser}) {//Si el parámetro esta envuelto de {} significa que es opcional
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<User> getById(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findById/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };
      final res = await http.get(url, headers: headers);
      if (res.statusCode == 401) {
        // No autorizado
        Fluttertoast.showToast(msg: 'Tu sesión expiró');
        new SharedPref().logout(context, idUser: sessionUser.id);
      }
      final data = json.decode(res.body);
      User user = User.fromJson(data);
      return user;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream> createWithImage(User user, File image) async {
    try {
      //Uri url = Uri.http(_url, '$_api/create');
      Uri url = Uri.https(_url, '$_api/createfull');
      final request = http.MultipartRequest('POST', url);
      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); // Se envía la petición

      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Stream> update(User user, File image) async {
    try {
      //Uri url = Uri.http(_url, '$_api/create');
      Uri url = Uri.http(_url, '$_api/update');
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization']= sessionUser.sessionToken;
      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);
      final response = await request.send(); // Se envía la petición
      if (response.statusCode == 401){
          Fluttertoast.showToast(msg: 'Tu sesión expiró');
              new SharedPref().logout(context, idUser: sessionUser.id);

      }
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final response = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final response = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ResponseApi> logout(String iduser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({
        'id': iduser
      });
      Map<String, String> headers = {'Content-type': 'application/json'};
      final response = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

}
