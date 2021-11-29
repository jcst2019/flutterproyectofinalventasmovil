import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyectofinalventasmovil/src/pages/almacenero/categories/create/almacenero_categories_controller.dart';
import 'package:proyectofinalventasmovil/src/pages/almacenero/orden/list/almacenero_orden_list_controller.dart';
import 'package:proyectofinalventasmovil/src/utils/my_colors.dart';

class AlmaceneroCategoriesCreatePage extends StatefulWidget {
  const AlmaceneroCategoriesCreatePage({Key key}) : super(key: key);

  @override
  _AlmaceneroCategoriesCreatePageState createState() =>
      _AlmaceneroCategoriesCreatePageState();
}

class _AlmaceneroCategoriesCreatePageState
    extends State<AlmaceneroCategoriesCreatePage> {
  AlmaceneroCategoriesController _almaceneroCategoriesController =
      new AlmaceneroCategoriesController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _almaceneroCategoriesController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva Categoria'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          _textFieldNameCategorie(),
          SizedBox(height: 30),
          _textFieldDesCategorie()
        ],
      ),
      bottomNavigationBar: _buttonCreateCategories(),
    );
  }

  Widget _textFieldNameCategorie() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _almaceneroCategoriesController.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre de la Categoría',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(Icons.list_alt, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _textFieldDesCategorie() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLines: 3,
        maxLength: 255,
        controller: _almaceneroCategoriesController.desController,
        decoration: InputDecoration(
            hintText: 'Descripción de la Categoría',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.primaryColorDark),
            prefixIcon: Icon(Icons.description, color: MyColors.primaryColor)),
      ),
    );
  }

  Widget _buttonCreateCategories() {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _almaceneroCategoriesController.createCategory,
        child: Text('Crear Categoría'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
