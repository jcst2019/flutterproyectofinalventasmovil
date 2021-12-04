import 'package:proyectofinalventasmovil/src/services/local_storage_service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

Future setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}
