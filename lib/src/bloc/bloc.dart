import 'dart:async';
// import 'package:rxdart/rxdart.dart';

// class Bloc with Validator {
class Bloc {
  //@override
  // TODO: implement opcionSeleccionada
  /*String get opcionSeleccionada => opcion;
  String get opcionSeleccionadaPago => opcionpago;

  final _usuarioController        = BehaviorSubject<String>();
  final _contrasenaController     = BehaviorSubject<String>();
  final _emailController          = BehaviorSubject<String>();
  final _passwordController       = BehaviorSubject<String>();
  final _nombreController         = BehaviorSubject<String>();
  final _apellidoController       = BehaviorSubject<String>();
  final _numeroController         = BehaviorSubject<String>();
  final _opcionController         = BehaviorSubject<String>();
  final _fecNacimientoController  = BehaviorSubject<String>();
  final _telefonoController       = BehaviorSubject<String>();
  final _referenciaController     = BehaviorSubject<String>();
  final _tpagoController          = BehaviorSubject<String>();
  final _valorEfectivoController  = BehaviorSubject<String>();
  final _opcionPago               = BehaviorSubject<String>();

  // Recuperar los datos del Stream

  Stream<String> get usuarioStream      => _usuarioController.stream.transform( validEmail() );
  Stream<String> get contrasenaStream   => _contrasenaController.stream.transform( validPassword() );
  Stream<String> get emailStream        => _emailController.stream.transform( validEmail() );
  Stream<String> get passwordStream     => _passwordController.stream.transform( validPassword() );
  Stream<String> get nombreStream       => _nombreController.stream.transform( validText() );
  Stream<String> get apellidoStream     => _apellidoController.stream.transform( validText() );
  Stream<String> get opcionStream     => _opcionController.stream.transform( validText() );
  Stream<String> get numeroDStream      => _numeroController.stream.transform( validLengthNumber() );
  Stream<String> get fecNacimientoStream => _fecNacimientoController.stream.transform(validNull());
  Stream<String> get telefonoStream      => _telefonoController.stream.transform( validTelefono() );
  Stream<String> get referenciaStream       => _referenciaController.stream.transform( validDireccion() );
  Stream<String> get tipoPagoStream       => _tpagoController.stream.transform( validAloneNumber() );
  Stream<String> get valorEfectivoStream       => _valorEfectivoController.stream.transform( validAloneNumber() );
  Stream<String> get opcionPago    => _opcionPago.stream.transform( validText() );

  Stream<bool> get formLoginStream      =>
      Observable.combineLatest2(usuarioStream, contrasenaStream, ( e, p) => true );

  Stream<bool> get formValidStream1     =>
      Observable.combineLatest4(nombreStream, apellidoStream, numeroDStream,fecNacimientoStream, ( e, p, n, m) => true );

  Stream<bool> get formValidStream2     =>
      Observable.combineLatest2(emailStream, passwordStream, ( e2, p2) => true );

  Stream<bool> get formValidStream3     =>
      Observable.combineLatest4(numeroDStream, telefonoStream, referenciaStream,valorEfectivoStream, ( e, p, n, m) => true );

  Stream<bool> get formValidStream5     =>
      Observable.combineLatest3(telefonoStream, referenciaStream,numeroDStream,(tl,t2, rf) => true );


  // Insertar valores al Stream
  Function(String) get changeUsuario        => _usuarioController.sink.add;
  Function(String) get changeContrasena     => _contrasenaController.sink.add;
  Function(String) get changeEmail          => _emailController.sink.add;
  Function(String) get changePassword       => _passwordController.sink.add;
  Function(String) get changeNombre         => _nombreController.sink.add;
  Function(String) get changeApellido       => _apellidoController.sink.add;
  Function(String) get changeNumeroD        => _numeroController.sink.add;
  Function(String) get changeopcion         => _opcionController.sink.add;
  Function(String) get changefecNacimiento  => _fecNacimientoController.sink.add;
  Function(String) get changeTefefono       => _telefonoController.sink.add;
  Function(String) get changeReferencia     => _referenciaController.sink.add;
  Function(String) get changeTipoPago       => _tpagoController.sink.add;
  Function(String) get changeValorEfectivo  => _valorEfectivoController.sink.add;
  Function(String) get changepago           => _opcionPago.sink.add;


  // Obtener el último valor ingresado a los streams
  String get usuario        => _usuarioController.value;
  String get contrasena     => _contrasenaController.value;
  String get email          => _emailController.value;
  String get password       => _passwordController.value;
  String get nombres        => _nombreController.value;
  String get apellidos      => _apellidoController.value;
  String get numeroD        => _numeroController.value;
  String get opcion         => _opcionController.value;
  String get fecNacimiento  => _fecNacimientoController.value;
  String get telefono       => _telefonoController.value;
  String get referencia     => _referenciaController.value;
  String get pago           => _tpagoController.value;
  String get valorEfectivo  => _valorEfectivoController.value;
  String get opcionpago     => _opcionPago.value;

  dispose() {
    _usuarioController?.close();
    _contrasenaController?.close();
    _emailController?.close();
    _passwordController?.close();
    _nombreController?.close();
    _apellidoController?.close();
    _numeroController?.close();
    _opcionController?.close();
    _fecNacimientoController?.close();
    _telefonoController?.close();
    _referenciaController?.close();
    _tpagoController?.close();
    _valorEfectivoController?.close();
    _opcionPago?.close();
  }*/

}
