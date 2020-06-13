import 'package:get_it/get_it.dart';
import 'package:stacked_firebase/src/services/authentication_service.dart';
import 'package:stacked_firebase/src/services/firestore_service.dart';
import 'package:stacked_services/stacked_services.dart';

final GetIt locator = GetIt.instance;

void setupLocators() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}
