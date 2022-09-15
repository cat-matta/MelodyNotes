import 'package:get_it/get_it.dart';
import './data/drift_db.dart';

final locator = GetIt.instance;

Future setupLocator() async {
  locator.registerLazySingleton(() => AppDb());
}