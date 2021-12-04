import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/config/constants.dart';
import 'package:provider/provider.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import 'carrito_controller.dart';

class CarritoPage extends StatefulWidget {
  @override
  _CarritoPage createState() => _CarritoPage();
}

class _CarritoPage extends State<CarritoPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  // var storageService = locator<LocalStorageService>();
  bool _isInAsyncCall = false;
  var cart;
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    cart = Provider.of<CarritoController>(context);
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.primaryColor,
            title: Text(Constants.appName,
                style: TextStyle(fontFamily: "Pacifico", fontSize: 30.00)),
            actions: <Widget>[],
            centerTitle: true,
          ),
          // body: ListView(
          //   children: _body(context),
          // ),
          body: Container(
              child: Column(
            children: [
              Expanded(
                child: Stepper(
                  controlsBuilder: (BuildContext context,
                      {onStepContinue, onStepCancel}) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        cart.getNumber() > 0
                            ? TextButton(
                                onPressed: onStepContinue,
                                child: const Text(
                                  'Continuar',
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            : Text(""),
                        _currentStep == 0
                            ? Text("")
                            : TextButton(
                                //onPressed: onStepCancel,
                                onPressed: onStepCancel,
                                child: const Text(
                                  'Cancelar',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                      ],
                    );
                  },
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  onStepContinue: continued,
                  onStepCancel: cancel,
                  steps: <Step>[
                    Step(
                      title: new Text('Detalle'),
                      content: Column(
                        children: _body(context),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('Dirección'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Dirección'),
                          ),
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Referencia'),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text('Método de pago'),
                      content: Column(
                        /*children: <Widget>[
                          TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Método de pago'),
                          ),
                        ],*/
                        children: [
                          CreditCardWidget(
                            cardNumber: cart.cardHolderName,
                            expiryDate: cart.expiredDate,
                            cardHolderName: cart.cardHolderName,
                            cvvCode: cart.cvvCode,
                            showBackView: cart
                                .isCvvFocused, //true when you want to show cvv(back) view
                            cardBgColor: MyColors.primaryColor,
                            animationDuration: Duration(milliseconds: 1000),
                            labelCardHolder: 'Nombre y Apellido',
                          ),
                          CreditCardForm(
                            formKey: cart.keyform, // Required
                            onCreditCardModelChange:
                                (cart.onCreditCardModelChange), // Required
                            themeColor: Colors.red,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumberDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Número de la Tarjeta',
                              hintText: 'XXXX XXXX XXXX XXXX',
                            ),
                            expiryDateDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Fecha de Expiración',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nombre del Titular',
                            ),
                          ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ],
          )),
          //bottomNavigationBar: _crearBoton(context),
        ));
  }

  List<Widget> _body(BuildContext context) {
    List<Widget> lista = [];

    print("cantidad --> ${cart.getNumber()}");

    if (cart.getNumber() > 0) {
      lista.add(_detalleCarro(context));
    } else {
      lista.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: Image.asset("assets/img/carrito-vacio.png",
                          width: 250, height: 250)),
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                        "No se han agregado" + "\n" + "productos al carrito",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green,
                            fontFamily: "Poppins-Medium",
                            fontSize: 18)),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return lista;
  }

  /*
  style: TextStyle(fontFamily: "Pacifico", fontSize: 30.00)
   */
  Widget _detalleCarro(BuildContext context) {
    var cart = Provider.of<CarritoController>(context);
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text("Detalle de pedido",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontFamily: "Pacifico",
                height: 2.5,
                decorationThickness: 25.0,
              )),
        ),
        Divider(
          color: MyColors.primaryColor,
          height: 5.0,
          indent: 10.0,
          endIndent: 10.0,
          thickness: 3.0,
        ),
        Column(
          children: getDetalle(context),
        ),
        Divider(
          color: MyColors.primaryColor,
          indent: 10.0,
          endIndent: 10.0,
          thickness: 3.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("")),
              Expanded(
                flex: 2,
                child: Text(
                  "Subtotal",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      //fontWeight: FontWeight.bold
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text("S/ ${cart.getSubTotal()}",
                      textAlign: TextAlign.end),
                ),
              ),
              Expanded(child: Text("")),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("")),
              Expanded(
                flex: 2,
                child: Text(
                  "IGV (18%)",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      //fontWeight: FontWeight.bold
                      ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text("S/. ${cart.getIgv()}", textAlign: TextAlign.end),
                ),
              ),
              Expanded(child: Text("")),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
          child: Row(
            children: <Widget>[
              Expanded(child: Text("")),
              Expanded(
                flex: 2,
                child: Text(
                  "Total",
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Text(
                    "S/ ${cart.getTotal()}",
                    textAlign: TextAlign.end,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(child: Text("")),
            ],
          ),
        ),
        //_crearBoton(context)
      ],
    );
  }

  List<Widget> getDetalle(BuildContext context) {
    var cart = Provider.of<CarritoController>(context);
    List<Widget> widgets = [];
    List<Map> detalle = cart.getDetalle();
    detalle.forEach((element) {
      widgets.add(Padding(
          padding: const EdgeInsets.only(
              left: 12.0, top: 5.0, right: 0.0, bottom: 5.0),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                "${element["cantidad"]}",
                textAlign: TextAlign.center,
              )),
              Expanded(flex: 2, child: Text(element["nombre"])),
              Expanded(
                  child: Text(
                "S/ ${element["total"]}",
                textAlign: TextAlign.end,
              )),
              Expanded(
                child: IconButton(
                  icon: Icon(
                    Icons.highlight_remove,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    cart.delete(element);
                  },
                ),
              )
            ],
          )));
    });
    return widgets;
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton(
        child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
            //child: Text('Ingresar',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            child: Text(
          'Realizar pedido',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        )),
        color: MyColors.primaryColor,
        textColor: Colors.white,
        onPressed: () {});
  }

  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < 2 ? setState(() => _currentStep += 1) : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
