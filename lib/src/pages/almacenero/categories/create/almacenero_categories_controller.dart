import 'package:flutter/cupertino.dart';
import 'package:proyectofinalventasmovil/src/utils/my_snackbar.dart';

class AlmaceneroCategoriesController{

  BuildContext context;
  Function refresh;

  TextEditingController nameController = new TextEditingController();
  TextEditingController desController = new TextEditingController();

  Future init(BuildContext context, Function refresh ){
        this.context = context;
        this.refresh = refresh;
  }
  void createCategory(){
  String name = nameController.text;
  String description = desController.text;
  if(name.isEmpty || description.isEmpty){
    MySnackbar.show(context, 'Debe ingresar todos los campos');
    return;
  }
  print('Nombre ${name}');
  print('Descripción ${description}');
}

}