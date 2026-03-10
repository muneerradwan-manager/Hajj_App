import 'package:get_it/get_it.dart';
import 'modules/core_module.dart';
import 'modules/auth_module.dart';
import 'modules/home_module.dart';
import 'modules/complaints_module.dart';
import 'modules/public_module.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  registerCoreModule();
  registerAuthModule();
  registerPublicModule();
  registerHomeModule();
  registerComplaintsModule();
}
