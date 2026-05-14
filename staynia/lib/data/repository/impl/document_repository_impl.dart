import 'package:dio/dio.dart';
import 'package:staynia/core/constants/api_url.dart';
import 'package:staynia/core/error_message.dart';
import 'package:staynia/core/network/http_app.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/document.dart';
import 'package:staynia/data/repository/document_repository.dart';

class DocumentRepositoryImpl extends HttpApp implements DocumentRepository {
  @override
  Future<ApiResult<List<Document>>> multiUpload(FormData formData) async {
    try {
      final res = await httpApp.post(
        ApiUrl.multiUploadDocument,
        data: formData,
      );
      final List<dynamic> data = res.data['payload'];
      final districts = data
          .map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList();
      return ApiResult.success(districts);
    } catch (e) {
      debug(e);
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Document>> uploadDocument(FormData formData) async {
    try {
      var response = await httpApp.post(ApiUrl.uploadDocument, data: formData);
      if (response.data["message"] == ApiResponse.success) {
        Document data = Document.fromJson(response.data["payload"]);
        return ApiResult.success(data);
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(response.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<bool>> deleteDocument(BaseRequestDTO dto) async {
    try {
      var response = await httpApp.delete(
        ApiUrl.deleteDocument,
        data: dto.toJson(),
      );
      if (response.data["message"] == ApiResponse.success) {
        return ApiResult.success(true);
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(response.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }

  @override
  Future<ApiResult<Document>> updateDocument(FormData formData) async {
    try {
      var response = await httpApp.put(ApiUrl.updateDocument, data: formData);
      if (response.data["message"] == ApiResponse.success) {
        Document data = Document.fromJson(response.data["payload"]);
        return ApiResult.success(data);
      }
      return ApiResult.failure(error: ErrorMessage.fromJson(response.data));
    } catch (_) {
      return ApiResult.failure();
    }
  }
}
