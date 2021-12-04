import 'package:flutter/material.dart';
import 'package:proyectofinalventasmovil/src/bloc/bloc.dart';

// class ProviderBloc extends InheritedWidget {
class Provider extends InheritedWidget {
  static var _instancia;

  factory Provider({key, child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key, child);
    }
    return _instancia;
  }

  Provider._internal(key, child) : super(key: key, child: child);

  final bloc = Bloc();

  // Provider({ Key key, Widget child })
  //   : super(key: key, child: child );

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Bloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>() as Provider)
        .bloc;
  }
}
