// Package imports:
import 'package:get_it/get_it.dart';
import 'package:idena_lib_dart/factory/api/api_coins_service.dart';
import 'package:idena_lib_dart/factory/app_service.dart';
import 'package:idena_lib_dart/factory/smart_contract_service.dart';
import 'package:idena_lib_dart/factory/validation_service.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/util/biometrics.dart';
import 'package:my_idena/util/hapticutil.dart';
import 'package:my_idena/util/sharedprefsutil.dart';
import 'package:my_idena/util/util_vps.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AppService>(() => AppService());
  sl.registerLazySingleton<SmartContractService>(() => SmartContractService());
  sl.registerLazySingleton<VpsUtil>(() => VpsUtil());
  sl.registerLazySingleton<ApiCoinsService>(() => ApiCoinsService());
  sl.registerLazySingleton<ValidationService>(() => ValidationService());
  sl.registerLazySingleton<DBHelper>(() => DBHelper());
  sl.registerLazySingleton<HapticUtil>(() => HapticUtil());
  sl.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  sl.registerLazySingleton<Vault>(() => Vault());
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  sl.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
}
