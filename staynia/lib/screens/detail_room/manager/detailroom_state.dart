
import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/room.dart';

class DetailroomState extends BaseCubitState<Room> {
  DetailroomState({
    super.loading,
    super.error,
    super.data,
  });

  @override
  DetailroomState copyWith({
    bool? loading,
    String? error,
    Room? data,
  }) {
    return DetailroomState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
