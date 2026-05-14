import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/room.dart';

class RoomState extends BaseCubitState<List<Room>> {
  RoomState({
    super.loading,
    super.error,
    super.data,
  });

  @override
  RoomState copyWith({
    bool? loading,
    String? error,
    List<Room>? data,
  }) {
    return RoomState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
