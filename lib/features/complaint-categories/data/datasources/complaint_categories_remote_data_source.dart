import 'package:bawabatelhajj/core/constants/app_urls.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';

import '../models/complaint_category_model.dart';

class ComplaintCategoriesRemoteDataSource {
  const ComplaintCategoriesRemoteDataSource(this._client);

  final DioClient _client;

  Future<List<ComplaintCategoryModel>> getAllComplaintCategories() async {
    final response = await _client.get(AppUrls.complaintCategories);
    final data = response.data as List<dynamic>? ?? [];
    return data
        .map((e) => ComplaintCategoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
