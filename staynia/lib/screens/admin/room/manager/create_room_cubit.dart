import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/dialog/app_dialog.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/category.dart';
import 'package:staynia/data/entity/model/document.dart';
import 'package:staynia/data/repository/document_repository.dart';
import 'package:staynia/data/repository/room_repository.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/screens/admin/room/manager/create_room_state.dart';

class CreateRoomCubit extends BaseCubit<CreateRoomState, RoomRepository> {
  CreateRoomCubit(RoomRepository repository, this.documentRepository)
    : super(CreateRoomState(), repository);

  final DocumentRepository documentRepository;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subTitleController = TextEditingController();
  final TextEditingController pricePerNightController = TextEditingController();
  final TextEditingController cleaningFeeController = TextEditingController();
  final TextEditingController serviceFeeController = TextEditingController();
  final List<int> maxGuests = List.generate(100, (index) => index + 1);
  final List<int> roomCount = List.generate(100, (index) => index + 1);
  final List<int> bathroomCount = List.generate(100, (index) => index + 1);
  String? description;
  List<Document>? documents;

  void setDescription(String? value) {
    description = value;
  }

  void updateDocument(Document? document) async {
    try {
      final formData = FormData.fromMap({
        'isPrimary': true,
        'id': document?.id,
      });
      await documentRepository.updateDocument(formData);
    } catch (_) {}
  }

  @override
  Future<void> onInit({dynamic arg}) async {}

  Future<void> create() async {
    List<int> documentIds = documents?.map((doc) => doc.id).toList() ?? [];
    List<int> categoryIds =
        state.categories?.map((value) => value.id!).toList() ?? [];
    List<int> commonIds =
        state.commons?.map((value) => value.id!).toList() ?? [];
    List<int> tagIds = state.tags?.map((value) => value.id!).toList() ?? [];

    context.unFocusInput;
    var dto = BaseRequestDTO(
      payload: {
        "categoryIds": categoryIds,
        "commonIds": commonIds,
        "tagIds": tagIds,
        "documentIds": documentIds,
        "title": titleController.text,
        "subTitle": subTitleController.text,
        "description": description,
        "pricePerNight": pricePerNightController.text.toCurrencyInt,
        "maxGuests": state.maxGuests,
        "cleaningFee": cleaningFeeController.text.toCurrencyInt,
        "serviceFee": serviceFeeController.text.toCurrencyInt,
        "roomCount": state.roomCount,
        "bathroomCount": state.bathroomCount,
      },
    );
    await showLoading();
    try {
      var res = await repository.create(dto);
      if (res.success) {
        showAlert(message: "Create Room Success");
      } else {
        showAlert(message: res.error?.message, code: res.error?.code);
      }
    } catch (_) {
    } finally {
      hideLoading();
    }
  }

  Future<void> removeCategory(int type, Category category) async {
    await showConfirmAlertDialog(
      buttonRight: "Remove",
      message: 'Do you want remove ${category.name}?',
      callBack: (isAgree) {
        if (isAgree) {
          final List<Category> data;
          if (type == 1) {
            data = List<Category>.from(state.categories ?? [])
              ..removeWhere((e) => e.id == category.id);
            emit(state.copyWith(categories: data));
          } else if (type == 2) {
            data = List<Category>.from(state.commons ?? [])
              ..removeWhere((e) => e.id == category.id);
            emit(state.copyWith(commons: data));
          } else if (type == 3) {
            data = List<Category>.from(state.tags ?? [])
              ..removeWhere((e) => e.id == category.id);
            emit(state.copyWith(tags: data));
          }
        }
      },
    );
  }

  Future<void> callBackCategory({
    required int type,
    List<Category>? data,
  }) async {
    if (data == null || data.isEmpty) return;
    if (type == 1) {
      emit(state.copyWith(categories: data));
    } else if (type == 3) {
      emit(state.copyWith(tags: data));
    } else {
      emit(state.copyWith(commons: data));
    }
  }

  Future<void> showMaxGuests() async {
    AppDialog.showAppActionSheet(
      context: context,
      title: 'Max Guests',
      cancelLabel: 'Cancel',
      onPopInvokedWithResult: (_, result) {
        emit(state.copyWith(maxGuests: result));
      },
      actions: [
        ...maxGuests.map((item) {
          return SheetAction<int>(
            label: item.toString(),
            key: item,
            isDefaultAction: state.maxGuests == item,
          );
        }),
      ],
    );
  }

  Future<void> showRoomCount() async {
    AppDialog.showAppActionSheet(
      context: context,
      title: 'Room Count',
      cancelLabel: 'Cancel',
      onPopInvokedWithResult: (_, result) {
        emit(state.copyWith(roomCount: result));
      },
      actions: [
        ...roomCount.map((item) {
          return SheetAction<int>(
            label: item.toString(),
            key: item,
            isDefaultAction: state.roomCount == item,
          );
        }),
      ],
    );
  }

  Future<void> showBathRoomCount() async {
    AppDialog.showAppActionSheet(
      context: context,
      title: 'Bath Room Count',
      cancelLabel: 'Cancel',
      onPopInvokedWithResult: (_, result) {
        emit(state.copyWith(bathroomCount: result));
      },
      actions: [
        ...bathroomCount.map((item) {
          return SheetAction<int>(
            label: item.toString(),
            key: item,
            isDefaultAction: state.bathroomCount == item,
          );
        }),
      ],
    );
  }
}
