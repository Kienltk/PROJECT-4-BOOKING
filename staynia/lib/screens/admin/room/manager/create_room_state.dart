import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/category.dart';
import 'package:staynia/data/entity/model/document.dart';

class CreateRoomState extends BaseCubitState<int> {
  CreateRoomState({
    super.loading,
    super.error,
    super.data,
    this.maxGuests,
    this.roomCount,
    this.bathroomCount,
    this.categories,
    this.tags,
    this.commons,
    this.documents,
  });
  final int? maxGuests;
  final int? roomCount;
  final int? bathroomCount;
  final List<Category>? categories;
  final List<Category>? tags;
  final List<Category>? commons;
  final List<Document>? documents;

  @override
  CreateRoomState copyWith({
    bool? loading,
    String? error,
    int? data,
    Object? maxGuests = BaseCubitState.noChange,
    Object? roomCount = BaseCubitState.noChange,
    Object? bathroomCount = BaseCubitState.noChange,
    List<Category>? categories,
    List<Category>? commons,
    List<Category>? tags,
    List<Document>? documents,
  }) {
    return CreateRoomState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
      categories: categories ?? this.categories,
      tags: tags ?? this.tags,
      commons: commons ?? this.commons,
      documents: documents ?? this.documents,
      maxGuests: identical(maxGuests, BaseCubitState.noChange)
          ? this.maxGuests
          : maxGuests as int?,
      roomCount: identical(roomCount, BaseCubitState.noChange)
          ? this.roomCount
          : roomCount as int?,
      bathroomCount: identical(bathroomCount, BaseCubitState.noChange)
          ? this.bathroomCount
          : bathroomCount as int?,
    );
  }
}
