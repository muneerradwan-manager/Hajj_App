import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Runtime environment values loaded from `.env`.
abstract final class EnvConfig {
  static String get apiBaseUrl {
    final value = dotenv.env['API_BASE_URL']?.trim() ?? '';
    if (value.isEmpty) {
      throw const FormatException(
        'Missing API_BASE_URL in .env',
      );
    }
    return value;
  }
}
