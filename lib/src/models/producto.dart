import 'package:flutter/material.dart';

@immutable
class Producto {
  final int id_producto;
  final String nombre;
  final double precio;
  final int stock_total;
  final String color;
  final int id_categoria;
  final String categoria;
  final int id_marca;
  final String marca;
  final String descripcion;
  final List imagenes_producto;
  final List detalle_stock;

  Producto(
      this.id_producto,
      this.nombre,
      this.precio,
      this.stock_total,
      this.color,
      this.id_categoria,
      this.categoria,
      this.id_marca,
      this.marca,
      this.descripcion,
      this.imagenes_producto,
      this.detalle_stock);

  Producto.fromJson(Map<String, dynamic> json)
      : id_producto = json['id_producto'],
        nombre = json['nombre'],
        precio = json['precio'],
        stock_total = json['stock_total'],
        color = json['color'],
        id_categoria = json['id_categoria'],
        categoria = json['categoria'],
        id_marca = json['id_marca'],
        marca = json['marca'],
        descripcion = json['descripcion'],
        imagenes_producto = json['imagenes_producto'],
        detalle_stock = json['detalle_stock'];

  Map<String, dynamic> toJson() => {
        'id_producto': id_producto,
        'nombre': nombre,
        'precio': precio,
        'stock_total': stock_total,
        'color': color,
        'id_categoria': id_categoria,
        'categoria': categoria,
        'id_marca': id_marca,
        'marca': marca,
        'descripcion': descripcion,
        'imagenes_producto': imagenes_producto,
        'detalle_stock': detalle_stock
      };
}
