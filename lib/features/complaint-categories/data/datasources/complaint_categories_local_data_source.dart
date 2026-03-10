import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/complaint_category_model.dart';

class ComplaintCategoriesLocalDataSource {
  static const _complaintCategoriesKey = 'cached_complaint_categories';
  static const _timestampKey = 'cached_complaint_categories_timestamp';
  static const _ttlMinutes = 60;

  Future<void> cacheComplaints(List<ComplaintCategoryModel> complaints) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(complaints.map((c) => c.toJson()).toList());
    await prefs.setString(_complaintCategoriesKey, encoded);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<List<ComplaintCategoryModel>?> getCachedComplaints() async {
    final prefs = await SharedPreferences.getInstance();

    final timestamp = prefs.getInt(_timestampKey);
    if (timestamp == null) return null;

    final age = DateTime.now().millisecondsSinceEpoch - timestamp;
    if (age > _ttlMinutes * 60 * 1000) return null; // expired

    final encoded = prefs.getString(_complaintCategoriesKey);
    if (encoded == null) return null;

    final decoded = jsonDecode(encoded) as List<dynamic>;
    return decoded
        .map((e) => ComplaintCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_complaintCategoriesKey);
    await prefs.remove(_timestampKey);
  }
}
