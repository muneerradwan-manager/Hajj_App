import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:hajj_app/features/auth/data/models/register_draft_model.dart';

class RegisterLocalDataSource {
  static const String _registerDraftKey = 'register_draft_cache';

  Future<void> saveDraft(RegisterDraftModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final payload = jsonEncode(model.toJson());
    await prefs.setString(_registerDraftKey, payload);
  }

  Future<RegisterDraftModel?> loadDraft() async {
    final prefs = await SharedPreferences.getInstance();
    final payload = prefs.getString(_registerDraftKey);

    if (payload == null || payload.trim().isEmpty) {
      return null;
    }

    final decoded = jsonDecode(payload);
    if (decoded is! Map) {
      return null;
    }

    return RegisterDraftModel.fromJson(
      decoded.map((key, value) => MapEntry(key.toString(), value)),
    );
  }

  Future<void> clearDraft() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_registerDraftKey);
  }
}
