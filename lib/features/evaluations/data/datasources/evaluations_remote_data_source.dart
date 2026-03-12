import 'package:bawabatelhajj/core/constants/app_urls.dart';
import 'package:bawabatelhajj/core/network/dio_client.dart';
import 'package:bawabatelhajj/features/evaluations/data/models/evaluation_question_model.dart';
import 'package:bawabatelhajj/features/evaluations/data/models/phase_model.dart';
import 'package:bawabatelhajj/features/evaluations/data/models/submit_phase_result_model.dart';

class EvaluationsRemoteDataSource {
  const EvaluationsRemoteDataSource(this._client);

  final DioClient _client;

  Future<List<PhaseModel>> getPhases() async {
    final response = await _client.get(AppUrls.phases);
    final data = response.data as List<dynamic>? ?? [];

    return data
        .map((e) => PhaseModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<EvaluationQuestionModel>> getUnansweredQuestions(
    int phaseId,
  ) async {
    final response = await _client.get(
      '${AppUrls.evaluationResults}/unanswered/phase/$phaseId',
    );
    final data = response.data as List<dynamic>? ?? [];

    return data
        .map((e) =>
            EvaluationQuestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<SubmitPhaseResultModel> submitPhase({
    required int phaseId,
    required List<Map<String, dynamic>> answers,
  }) async {
    final response = await _client.post(
      '${AppUrls.evaluationResults}/submit-phase',
      data: {
        'phaseId': phaseId,
        'answers': answers,
      },
    );

    return SubmitPhaseResultModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}
