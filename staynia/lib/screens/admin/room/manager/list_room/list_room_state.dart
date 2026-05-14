
import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/room.dart';

class ListRoomState extends BaseCubitState<List<Room>> {
  ListRoomState({
    super.loading,
    super.error,
    super.data,
  });

  @override
  ListRoomState copyWith({
    bool? loading,
    String? error,
    List<Room>? data,
  }) {
    return ListRoomState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
