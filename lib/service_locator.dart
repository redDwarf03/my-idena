import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'package:my_idena/model/db/appdb.dart';
import 'package:my_idena/model/vault.dart';
import 'package:my_idena/service/app_service.dart';
import 'package:my_idena/service/coins_service.dart';
import 'package:my_idena/service/smart_contract_service.dart';
import 'package:my_idena/service/validation_service.dart';
import 'package:my_idena/util/hapticutil.dart';
import 'package:my_idena/util/biometrics.dart';
import 'package:my_idena/util/sharedprefsutil.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AppService>(() => AppService());
  sl.registerLazySingleton<SmartContractService>(() => SmartContractService());
  sl.registerLazySingleton<CoinsService>(() => CoinsService());
  sl.registerLazySingleton<ValidationService>(() => ValidationService());
  sl.registerLazySingleton<DBHelper>(() => DBHelper());
  sl.registerLazySingleton<HapticUtil>(() => HapticUtil());
  sl.registerLazySingleton<BiometricUtil>(() => BiometricUtil());
  sl.registerLazySingleton<Vault>(() => Vault());
  sl.registerLazySingleton<SharedPrefsUtil>(() => SharedPrefsUtil());
  sl.registerLazySingleton<Logger>(() => Logger(printer: PrettyPrinter()));
}