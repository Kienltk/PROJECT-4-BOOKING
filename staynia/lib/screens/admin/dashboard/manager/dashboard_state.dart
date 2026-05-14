import 'package:staynia/core/base/bloc/base_cubit_state.dart';

class DashboardState extends BaseCubitState<int> {
  DashboardState({super.loading, super.error, super.data});

  @override
  DashboardState copyWith({
    bool? loading,
    String? error,
    int? data,
    Object? selectedRaisingCapital = BaseCubitState.noChange,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
