import 'package:bawabatelhajj/core/constants/app_urls.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';

import '../models/complaint_kind_model.dart';

class ComplaintKindsRemoteDataSource {
  const ComplaintKindsRemoteDataSource(this._client);

  final DioClient _client;

  Future<List<ComplaintKindModel>> getAllComplaintKinds() async {
    final response = await _client.get(AppUrls.complaintKinds);
    final data = response.data as List<dynamic>? ?? [];
    return data
        .map((e) => ComplaintKindModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
