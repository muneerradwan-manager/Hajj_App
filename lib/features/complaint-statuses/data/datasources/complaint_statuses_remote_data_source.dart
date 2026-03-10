import 'package:bawabatelhajj/core/constants/app_urls.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';

import '../models/complaint_status_model.dart';

class ComplaintStatusesRemoteDataSource {
  const ComplaintStatusesRemoteDataSource(this._client);

  final DioClient _client;

  Future<List<ComplaintStatusModel>> getAllComplaintStatuses() async {
    final response = await _client.get(AppUrls.complaintStatuses);
    final data = response.data as List<dynamic>? ?? [];
    return data
        .map((e) => ComplaintStatusModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
