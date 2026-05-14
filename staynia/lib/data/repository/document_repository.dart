
import 'package:dio/dio.dart';
import 'package:staynia/data/entity/model/api_result.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/document.dart';

abstract class DocumentRepository {
   Future<ApiResult<List<Document>>> multiUpload(FormData formData);
   Future<ApiResult<Document>> uploadDocument(FormData formData);
   Future<ApiResult<Document>> updateDocument(FormData formData);
   Future<ApiResult<bool>> deleteDocument(BaseRequestDTO dto);
}
