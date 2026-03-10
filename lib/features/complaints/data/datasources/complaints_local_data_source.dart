import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:bawabatelhajj/features/complaints/data/models/complaint_model.dart';

class ComplaintsLocalDataSource {
  static const _complaintsKey = 'cached_complaints';
  static const _timestampKey = 'cached_complaints_timestamp';
  static const _ttlMinutes = 60; // 1 hour TTL

  Future<void> cacheComplaints(List<ComplaintModel> complaints) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(complaints.map((c) => c.toJson()).toList());
    await prefs.setString(_complaintsKey, encoded);
    await prefs.setInt(
      _timestampKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<List<ComplaintModel>?> getCachedComplaints() async {
    final prefs = await SharedPreferences.getInstance();

    final timestamp = prefs.getInt(_timestampKey);
    if (timestamp == null) return null;

    final age = DateTime.now().millisecondsSinceEpoch - timestamp;
    if (age > _ttlMinutes * 60 * 1000) return null; // expired

    final encoded = prefs.getString(_complaintsKey);
    if (encoded == null) return null;

    final decoded = jsonDecode(encoded) as List<dynamic>;
    return decoded
        .map((e) => ComplaintModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_complaintsKey);
    await prefs.remove(_timestampKey);
  }
}
