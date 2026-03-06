import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bawabatelhajj/core/di/dependency_injection.dart';
import 'package:bawabatelhajj/core/localization/localization_cubit.dart';

import '../services/keyboard_resync_service.dart';

Future<void> bootstrapApp() async {
  await dotenv.load(fileName: '.env');
  setupDependencies();
  await getIt<LocalizationCubit>().loadSavedLocale();
  await getIt<KeyboardResyncService>().initialize();
}
