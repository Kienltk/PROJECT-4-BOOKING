import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/document.dart';

class DocumentState extends BaseCubitState<List<Document>> {
  DocumentState({super.loading, super.error, super.data});

  @override
  DocumentState copyWith({
    bool? loading,
    String? error,
    List<Document>? data,
    Object? selectedRaisingCapital = BaseCubitState.noChange,
  }) {
    return DocumentState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
