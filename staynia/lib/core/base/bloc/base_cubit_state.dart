class BaseCubitState<T> {
  final bool loading;
  final String? error;
  final T? data;
  static const Object noChange = Object();

  BaseCubitState({this.loading = false, this.error, this.data});

  BaseCubitState<T> copyWith({bool? loading, String? error, T? data}) {
    return BaseCubitState<T>(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
