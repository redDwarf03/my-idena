// Package imports:
import 'package:get_it/get_it.dart';
import 'package:idena_lib_dart/factory/api/api_coins_service.dart';
import 'package:idena_lib_dart/factory/app_service.dart';
import 'package:idena_lib_dart/factory/smart_contract_service.dart';
import 'package:idena_lib_dart/factory/validation_service.dart';
import 'package:idena_lib_dart/util/util_vps.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/util/biometrics.dart';
import 'package:my_idena/util/hapticutil.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

GetIt sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  if (sl.isRegistered<SharedPrefsUtil>()) {
    sl.unregister<SharedPrefsUtil>();
  }
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());

  int nodeType = await sl.get<SharedPrefsUtil>().getNodeType();
  Uri uriApiUrl = await sl.get<SharedPrefsUtil>().getApiUrl();
  String apiUrl = "";
  if (uriApiUrl != null) {
    apiUrl = uriApiUrl.toString();
  }
  String keyApp = await sl.get<SharedPrefsUtil>().getKeyApp();

  if (sl.isRegistered<AppService>()) {
    sl.unregister<AppService>();
  }
  sl.registerLazySingleton<AppService>(
      () => AppService(nodeType: nodeType, apiUrl: apiUrl, keyApp: keyApp));
      
  if (sl.isRegistered<SmartContractService>()) {
    sl.unregister<SmartContractService>();
  }
  sl.registerLazySingleton<SmartContractService>(() =>
      SmartContractService(nodeType: nodeType, apiUrl: apiUrl, keyApp: keyApp));

  if (sl.isRegistered<VpsUtil>()) {
    sl.unregister<VpsUtil>();
  }
  sl.registerLazySingleton<VpsUtil>(() => VpsUtil());

  if (sl.isRegistered<ApiCoinsService>()) {
    sl.unregister<ApiCoinsService>();
  }
  sl.registerLazySingleton<ApiCoinsService>(() => ApiCoinsService());

  if (sl.isRegistered<ValidationService>()) {
    sl.unregister<ValidationService>();
  }
  sl.registerLazySingleton<ValidationService>(() =>
      ValidationService(nodeType: nodeType, apiUrl: apiUrl, keyApp: keyApp));

  if (sl.isRegistered<DBHelper>()) {
    sl.unregister<DBHelper>();
  }
  sl.registerLazySingleton<DBHelper>(() => DBHelper());

  if (sl.isRegistered<HapticUtil>()) {
    sl.unregister<HapticUtil>();
  }
  sl.registerLazySingleton<HapticUtil>(() => HapticUtil());
  
  if (sl.isRegistered<BiometricUtil>()) {
    sl.unregister<BiometricUtil>();
  }
  sl.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  
  if (sl.isRegistered<Vault>()) {
    sl.unregister<Vault>();
  }
  sl.registerLazySingleton<Vault>(() => Vault());
  
  if (sl.isRegistered<Logger>()) {
    sl.unregister<Logger>();
  }
  sl.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
}
