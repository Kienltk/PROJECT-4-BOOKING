import 'package:flutter/material.dart';
import 'package:staynia/components/button/app_button.dart';
import 'package:staynia/components/container/bottom_container.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/input/custom_input.dart';
import 'package:staynia/components/input/custom_text_area.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/utils/app_bottom_sheet/app_bottom_sheet.dart';
import 'package:staynia/data/entity/enum/app_button_type.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/category.dart';
import 'package:staynia/data/repository/category_repository.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/providers/manager/category/manager/category_state.dart';

class CategoryCubit extends BaseCubit<CategoryState, CategoryRepository> {
  CategoryCubit(CategoryRepository repository)
    : super(CategoryState(), repository);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Future<void> onInit({dynamic arg}) async {
    int type = (arg != null ? (arg as int) : 100);
    emit(state.copyWith(loading: true));
    try {
      switch (type) {
        case 1:
          var res = await repository.getByType(
            BaseRequestDTO(
              payload: {"page": page, "limit": 1000, "type": "CATEGORY"},
            ),
          );
          if (res.success) {
            emit(state.copyWith(data: res.data));
          }
        case 2:
          var res = await repository.getByType(
            BaseRequestDTO(
              payload: {"page": page, "limit": 1000, "type": "COMMON"},
            ),
          );
          if (res.success) {
            emit(state.copyWith(commons: res.data));
          }
        case 3:
          var res = await repository.getByType(
            BaseRequestDTO(
              payload: {"page": page, "limit": 1000, "type": "TAG"},
            ),
          );
          if (res.success) {
            emit(state.copyWith(tags: res.data));
          }
        default:
          var res = await repository.getByType(
            BaseRequestDTO(
              payload: {"page": page, "limit": 1000, "type": "CATEGORY"},
            ),
          );
          var res2 = await repository.getByType(
            BaseRequestDTO(
              payload: {"page": page, "limit": 1000, "type": "COMMON"},
            ),
          );
          var res3 = await repository.getByType(
            BaseRequestDTO(
              payload: {"page": page, "limit": 1000, "type": "TAG"},
            ),
          );
          debug(res);
          if (res.success) {
            emit(state.copyWith(data: res.data));
          }
          if (res2.success) {
            emit(state.copyWith(commons: res2.data));
          }
          if (res3.success) {
            emit(state.copyWith(tags: res3.data));
          }
      }
    } catch (_) {
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void handleCreate(String type) async {
    try {
      await showLoading();
      var res = await repository.create(
        BaseRequestDTO(
          payload: {
            "type": type,
            "name": nameController.text,
            "description": descriptionController.text,
            "status": 1,
          },
        ),
      );
      if (res.success) {
        context.goBack();
        if (type == "CATEGORY") {
          emit(
            state.copyWith(
              data: [...(state.data ?? []), if (res.data != null) res.data!],
            ),
          );
        } else {
          emit(
            state.copyWith(
              tags: [...(state.tags ?? []), if (res.data != null) res.data!],
            ),
          );
        }
        showAlert(message: 'Create ${nameController.text} Success!');
        nameController.clear();
        descriptionController.clear();
      } else {
        showAlert(message: res.error?.message, code: res.error?.code);
      }
    } catch (_) {
      showAlert();
    } finally {
      hideLoading();
    }
  }

  void create(String type) async {
    AppBottomSheet.showAppBottomSheet(
      context: context,
      closeButton: false,
      child: ContainerBody(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomInput(
                label: "Name",
                hintText: "Enter Name",
                isRequired: true,
                padding: const EdgeInsets.only(bottom: 10),
                controller: nameController,
              ),
              CustomTextArea(
                controller: descriptionController,
                hintText: descriptionController.text,
                label: 'Description',
              ),
              Box.s12,
              AppButton(
                content: "Submit",
                type: AppButtonType.primary,
                onClick: () {
                  handleCreate(type);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateCategory(Category category) async {
    try {
      await showLoading();
      await repository.update(BaseRequestDTO(payload: category.toJson())).then((
        res,
      ) {
        if (res.success) {
          context.goBack();
          showAlert(message: "Update Category success!");
        } else {
          showAlert(message: res.error?.message, code: res.error?.code);
        }
      });
    } catch (_) {
      showAlert();
    } finally {
      hideLoading();
    }
  }

  Future<void> onCategoryClick({
    required Category category,
    required int type,
  }) async {
    AppBottomSheet.showAppBottomSheet(
      context: context,
      closeButton: false,
      child: ContainerBody(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (type == 2) ...[
                    buildIcons(false, category.icon ?? ''),
                    Box.s16,
                  ],
                  Text(category.name ?? '-'),
                ],
              ),
              Box.s16,
              CustomTextArea(
                controller: TextEditingController(),
                hintText: category.description,
                label: 'Description',
                onChanged: (value) {
                  category.description = value;
                },
              ),
              Box.s12,
              AppButton(
                content: "Submit",
                type: AppButtonType.primary,
                onClick: () {
                  updateCategory(category);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showIcons({
    List<Category>? data,
    required int type,
    required Function(List<Category>? data) callBack,
  }) async {
    final List<Category> selected = List<Category>.from(data ?? []);
    final List<Category> categories;
    if (type == 1) {
      categories = state.data ?? [];
    } else if (type == 3) {
      categories = state.tags ?? [];
    } else {
      categories = state.commons ?? [];
    }

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SafeArea(
              bottom: false,
              child: ContainerBody(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                          top: (type == 1 || type == 3) ? 20 : 80,
                        ),
                        itemCount: categories.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (type == 1 || type == 3) ? 4 : 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                        ),
                        itemBuilder: (context, index) {
                          final item = categories[index];
                          final isSelected = selected.any(
                            (e) => e.id == item.id,
                          );

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isSelected) {
                                  selected.removeWhere((e) => e.id == item.id);
                                } else {
                                  selected.add(item);
                                }
                              });
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (type == 2)
                                  buildIcons(isSelected, item.icon ?? ''),
                                Box.s14,
                                if (type == 1 || type == 3) ...[
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(
                                        defaultBorderRadious,
                                      ),
                                      border: Border.all(
                                        color: isSelected
                                            ? context.primaryColor
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      item.name!,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ] else
                                  Text(
                                    item.name!,
                                    style: const TextStyle(fontSize: 11),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    BottomContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              callBack(null);
                            },
                            child: const Text('Cancel'),
                          ),
                          SizedBox(
                            width: context.sizeWidth * 0.25,
                            child: AppButton(
                              type: AppButtonType.primary,
                              content: "Next",
                              onClick: () {
                                Navigator.pop(ctx);
                                callBack(selected);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget buildIcons(bool isSelected, String icon) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(defaultBorderRadious),
        border: Border.all(
          color: isSelected ? context.primaryColor : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: AppAssetIcon(icon, size: 50, color: Colors.black),
    );
  }
}
