import 'package:flutter/cupertino.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class CarritoController with ChangeNotifier {
  List<Map> detalle = [];
  var orden = null;
  String _cardNumber = '';
  String _expiredDate = '';
  String _cardHolderName = '';
  String _cvvCode = '';
  bool _isCvvFocused = false;
  GlobalKey <FormState> _keyform = new GlobalKey();

  CartController() {
    init();
  }

  void init() {}

  // Agregar a carrito
  add(product) {
    int quantity = int.parse(count(product.id_producto).toString()) + 1;
    int stock = product.stock_total;

    if (detalle.length > 0) {
      if (!detalle
          .map((item) => item["id_producto"])
          .toList()
          .contains(product.id_producto)) {
        if (stock >= quantity) {
          Map map = {
            "id_producto": product.id_producto,
            "cantidad": quantity,
            "nombre": product.nombre,
            "precio": product.precio,
            "total": formatDecimal((product.precio * quantity).toString()),
            "stock": stock
          };
          detalle.add(map);
        }
      } else {
        if (quantity > 1) {
          if (detalle
              .map((item) => item["id_producto"])
              .toList()
              .contains(product.id_producto)) {
            if (stock >= quantity) {
              detalle.removeWhere(
                      (item) => item["id_producto"] == product.id_producto);
              Map map = {
                "id_producto": product.id_producto,
                "cantidad": quantity.toString(),
                "nombre": product.nombre,
                "precio": product.precio,
                "total": formatDecimal((product.precio * quantity).toString()),
                "stock": stock
              };
              detalle.add(map);
            }
          }
        }
      }
    } else {
      if (stock >= quantity) {
        Map map = {
          "id_producto": product.id_producto,
          "cantidad": quantity.toString(),
          "nombre": product.nombre,
          "precio": product.precio,
          "total": formatDecimal((product.precio * quantity).toString()),
          "stock": stock
        };
        detalle.add(map);
      }
    }
    // print("detalle -->${detalle}");
    notifyListeners();
  }

  // Quitar de carrito
  remove(product) {
    int cantidad = count(product.id_producto);
    int stock = product.stock_total;
    if (cantidad > 1) {
      detalle.removeWhere((item) => item["id_producto"] == product.id_producto);
      int quantity = cantidad - 1;
      Map map = {
        "id_producto": product.id_producto,
        "cantidad": quantity,
        "nombre": product.nombre,
        "precio": product.precio,
        "total": formatDecimal((product.precio * quantity).toString()),
        "stock": stock
      };
      detalle.add(map);
    } else {
      for (int i = 0; i < detalle.length; i++) {
        var data = detalle[i];
        if (data["id_producto"] == product.id_producto) {
          detalle.removeAt(i);
        }
      }
    }
    notifyListeners();
  }

  delete(data) {
    detalle.removeWhere(
            (element) => data["id_producto"] == element["id_producto"]);
    notifyListeners();
  }

  clear() {
    orden = null;
    detalle = [];
    nroOrden = "";
    notifyListeners();
  }

  count(id) {
    int cont = 0;
    detalle.forEach((element) {
      if (id == element["id_producto"]) {
        cont = cont + int.parse("${element["cantidad"]}");
      }
    });
    return cont;
  }

  getNumber() {
    int cont = 0;
    for (int i = 0; i < detalle.length; i++) {
      var data = detalle[i];
      cont = cont + int.parse(data["cantidad"].toString());
    }

    return cont;
    //return _itemIds.length;
  }

  getDetalle() {
    return detalle;
  }

  String formatDecimal(String decimal) {
    String value = "";
    var number = decimal.split(".");
    if (number[1].length == 1) {
      value = decimal + "0";
    } else {
      value = decimal.substring(0, 5);
    }
    return value;
  }

  getSubTotal() {
    double total = 00.00;
    for (int i = 0; i < detalle.length; i++) {
      var menu = detalle[i];
      total = total + double.parse(menu["total"]);
    }
    NumberFormat f = new NumberFormat("#.##");
    var tot = formatDecimal((total).toString());
    //print(f.format(double.parse(tot)/1.18));
    return double.parse(f.format(double.parse(tot) / 1.18));
  }

  // IGV
  getIgv() {
    double total = 00.00;
    for (int i = 0; i < detalle.length; i++) {
      var menu = detalle[i];
      total = total + double.parse(menu["total"]);
    }
    NumberFormat f = new NumberFormat("#.##");
    var total1 = formatDecimal((total).toString());
    return double.parse(f.format(double.parse(total1) - getSubTotal()));
  }

  // Total carrito
  getTotal() {
    double total = 00.00;
    for (int i = 0; i < detalle.length; i++) {
      var menu = detalle[i];
      total = total + double.parse(menu["total"]);
    }
    //return formatDecimal(getSubTotal().toString()+getIgv().toString());
    return formatDecimal((total).toString());
  }

  CrearOrden(usuario, documento, telefono, direccion, pago, valor_efectivo) {
    switch (pago) {
      case ("Efectivo"):
        {
          pago = 1;
        }
        break;
      case ("Visa"):
        {
          pago = 2;
        }
        break;
      case ("MasterCard"):
        {
          pago = 3;
        }
        break;
      default:
        {
          pago = 4;
        }
        break;
    }
    orden = {};
    orden["usuario"] = usuario;
    orden["nroDocumento"] = documento;
    orden["telefono"] = telefono;
    orden["direccion_entrega"] = direccion;
    orden["id_tipo_pago"] = pago;
    orden["valor_efectivo"] = valor_efectivo;
    orden["detalle"] = detalle;
    orden["total_descartables"] = getIgv();
    orden["total_orden"] = getTotal();
    notifyListeners();
  }

  getOrden() {
    return orden;
  }

  String nroOrden = "";

  setNroOrden(nro) {
    nroOrden = nro;
    notifyListeners();
  }

  getNroOrden() {
    return nroOrden;
  }

  Null pedidos = null;

  setPedidos(res) {
    pedidos = res;
    //pedidos.add(res);
    notifyListeners();
  }

  getPedidos() {
    return pedidos;
  }

  bool get isCvvFocused => _isCvvFocused;

  set isCvvFocused(bool value) {
    _isCvvFocused = value;
  }

  String get cvvCode => _cvvCode;

  set cvvCode(String value) {
    _cvvCode = value;
  }

  String get cardHolderName => _cardHolderName;

  set cardHolderName(String value) {
    _cardHolderName = value;
  }

  String get expiredDate => _expiredDate;

  set expiredDate(String value) {
    _expiredDate = value;
  }

  String get cardNumber => _cardNumber;

  set cardNumber(String value) {
    _cardNumber = value;
  }

  GlobalKey<FormState> get keyform => _keyform;

  set keyform(GlobalKey<FormState> value) {
    _keyform = value;
  }

  onCreditCardModelChange(CreditCardModel creditCardModel) {
    _cardNumber = creditCardModel.cardNumber;
    _expiredDate = creditCardModel.expiryDate;
    _cardHolderName = creditCardModel.cardHolderName;
    _cvvCode = creditCardModel.cvvCode;
    _isCvvFocused = creditCardModel.isCvvFocused;
  }
}
