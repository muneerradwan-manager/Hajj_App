import 'package:flutter/widgets.dart';

import 'package:hajj_app/core/localization/app_localizations_setup.dart';

class AppValidators {
  const AppValidators._();

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static const String _requiredKey = 'validation.required';
  static const String _emailRequiredKey =
      'auth.forget.validation_email_required';
  static const String _emailInvalidKey = 'auth.forget.validation_email_invalid';
  static const String _phoneRequiredKey = 'auth.login.phone_required';
  static const String _passwordRequiredKey = 'auth.login.password_required';
  static const String _passwordMinLengthKey = 'auth.login.password_min_length';
  static const String _confirmPasswordRequiredKey =
      'auth.register.validation_confirm_password_required';
  static const String _confirmPasswordMismatchKey =
      'validation.confirm_password_mismatch';
  static const String _nationalIdRequiredKey =
      'auth.register.validation_national_id_required';
  static const String _barcodeRequiredKey =
      'auth.register.validation_barcode_required';
  static const String _verificationCodeRequiredKey =
      'auth.register.validation_verification_code_required';
  static const String _verificationCodeInvalidKey =
      'auth.register.validation_verification_code_invalid';

  static String _normalize(String? value) => (value ?? '').trim();

  static String? _requiredWithKey(
    String? value,
    BuildContext context,
    String key,
  ) {
    if (_normalize(value).isEmpty) {
      return key.tr(context);
    }
    return null;
  }

  static String? notEmpty(String? value, BuildContext context) {
    return _requiredWithKey(value, context, _requiredKey);
  }

  static String? text(String? value, BuildContext context) {
    return notEmpty(value, context);
  }

  static String? nationalId(String? value, BuildContext context) {
    return _requiredWithKey(value, context, _nationalIdRequiredKey);
  }

  static String? barcode(String? value, BuildContext context) {
    return _requiredWithKey(value, context, _barcodeRequiredKey);
  }

  static String? verificationCode(
    String? value,
    BuildContext context, {
    int length = 6,
  }) {
    final normalized = _normalize(value);
    if (normalized.isEmpty) {
      return _verificationCodeRequiredKey.tr(context);
    }

    final isDigitsOnly = RegExp(r'^\d+$').hasMatch(normalized);
    if (!isDigitsOnly || normalized.length != length) {
      return _verificationCodeInvalidKey.tr(context, args: {'length': length});
    }

    return null;
  }

  static String? phone(String? value, BuildContext context) {
    return _requiredWithKey(value, context, _phoneRequiredKey);
  }

  static String? email(String? value, BuildContext context) {
    final requiredError = _requiredWithKey(value, context, _emailRequiredKey);
    if (requiredError != null) return requiredError;

    if (!_emailRegex.hasMatch(_normalize(value))) {
      return _emailInvalidKey.tr(context);
    }
    return null;
  }

  static String? password(String? value, BuildContext context) {
    final normalized = _normalize(value);

    if (normalized.isEmpty) {
      return _passwordRequiredKey.tr(context);
    }

    if (normalized.length < 6) {
      return _passwordMinLengthKey.tr(context);
    }

    return null;
  }

  static String? confirmPassword(
    String? value,
    BuildContext context, {
    String? originalPassword,
  }) {
    final requiredError = _requiredWithKey(
      value,
      context,
      _confirmPasswordRequiredKey,
    );
    if (requiredError != null) return requiredError;

    if (originalPassword != null &&
        _normalize(value) != _normalize(originalPassword)) {
      return _confirmPasswordMismatchKey.tr(context);
    }

    return null;
  }
}
