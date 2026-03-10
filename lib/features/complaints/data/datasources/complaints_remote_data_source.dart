import 'dart:io';

import 'package:bawabatelhajj/core/constants/app_urls.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';
import 'package:bawabatelhajj/core/network/safe_api_call.dart';
import 'package:bawabatelhajj/features/complaints/data/models/complaint_model.dart';
import 'package:dio/dio.dart';

class ComplaintsRemoteDataSource {
  const ComplaintsRemoteDataSource(this._client);

  final DioClient _client;

  Future<List<ComplaintModel>> getMyComplaints() async {
    final response = await _client.get('${AppUrls.complaints}/my');
    final data = response.data as List<dynamic>? ?? [];

    return data
        .map((e) => ComplaintModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<ComplaintModel> getComplaintDetails(int id) async {
    final result = await safeApiCall(
      apiCall: () => _client.get('${AppUrls.complaints}/$id'),
      mapper: (json) =>
          ComplaintModel.fromJson(json['data'] as Map<String, dynamic>),
    );

    return result.fold(
      (failure) => throw Exception(failure.userMessage),
      (data) => data,
    );
  }

  Future<String> createComplaint({
    required int categoryId,
    required int kindId,
    required String subject,
    required String message,
    required List<File> attachments,
  }) async {
    final formData = FormData();

    formData.fields.addAll([
      MapEntry('CategoryId', categoryId.toString()),
      MapEntry('KindId', kindId.toString()),
      MapEntry('Subject', subject),
      MapEntry('Message', message),
    ]);

    for (final file in attachments) {
      formData.files.add(
        MapEntry(
          'Attachments[]',
          await MultipartFile.fromFile(
            file.path,
            filename: file.path.split('/').last,
          ),
        ),
      );
    }

    final result = await safeApiCall(
      apiCall: () => _client.post(
        AppUrls.complaints,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      ),
      mapper: (json) => json['message'] as String? ?? '',
    );

    return result.fold(
      (failure) => throw Exception(failure.userMessage),
      (data) => data,
    );
  }
}
