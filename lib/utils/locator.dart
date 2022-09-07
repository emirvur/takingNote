import 'package:get_it/get_it.dart';
import 'package:tea/services/APIServices.dart';

GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerLazySingleton(() => APIServices());
}
