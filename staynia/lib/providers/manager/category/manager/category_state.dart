import 'package:staynia/core/base/bloc/base_cubit_state.dart';
import 'package:staynia/data/entity/model/category.dart';

class CategoryState extends BaseCubitState<List<Category>> {
  CategoryState({
    super.loading,
    super.error,
    super.data,
    this.selectedCategories,
    this.selectedCommmons,
    this.commons,
    this.tags,
    this.selectedTags,
  });
  List<Category>? selectedCategories;
  List<Category>? commons;
  List<Category>? selectedCommmons;
  List<Category>? tags;
  List<Category>? selectedTags;

  @override
  CategoryState copyWith({
    bool? loading,
    String? error,
    List<Category>? data,
    List<Category>? selectedCategories,
    List<Category>? commons,
    List<Category>? selectedCommmons,
    List<Category>? tags,
    List<Category>? selectedTags,
  }) {
    return CategoryState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
      data: data ?? this.data,
      selectedCommmons: selectedCommmons ?? this.selectedCommmons,
      tags: tags ?? this.tags,
      selectedTags: selectedTags ?? this.selectedTags,
      commons: commons ?? this.commons,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }
}
