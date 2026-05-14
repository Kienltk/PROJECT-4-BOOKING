import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/button/blur_button.dart';
import 'package:staynia/components/media/app_cache_image.dart';
import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/utils/utils.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/entity/model/document.dart';
import 'package:staynia/data/repository/document_repository.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/providers/manager/document/document_state.dart';

class DocumentCubit extends BaseCubit<DocumentState, DocumentRepository> {
  DocumentCubit(DocumentRepository r) : super(DocumentState(), r) {
    pageController = PageController();
  }
  late PageController pageController;

  @override
  Future<void> onInit({dynamic arg}) async {}

  Future<void> handleFile({
    Function(List<Document>? documents)? callBack,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );

    if (result == null) return;

    await showLoading();
    try {
      final files = result.paths
          .where((path) => path != null)
          .map((path) => File(path!))
          .toList();

      final List<Document> data = [];
      for (int i = 0; i < files.length; i++) {
        final file = files[i];
        final isPrimary = i == 0;
        final res = await uploadDocument(file, isPrimary);
        if (res != null) data.add(res);
      }

      emit(state.copyWith(data: [...(state.data ?? []), ...data]));
      callBack?.call(state.data);
    } catch (e) {
      debugPrint('handleFile error: $e');
    } finally {
      hideLoading();
    }
  }

  Future<Document?> uploadDocument(File file, bool isPrimary) async {
    final formData = FormData.fromMap({
      'isPrimary': false,
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final res = await repository.uploadDocument(formData);
    return res.success ? res.data : null;
  }

  Future<Document?> updateDocument(Document document, File file) async {
    final formData = FormData.fromMap({
      'isPrimary': document.isPrimary,
      'id': document.id,
      'file': await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      ),
    });

    final res = await repository.updateDocument(formData);
    return res.success ? res.data : null;
  }

  Future<bool?> deleteDocument(Document document) async {
    final res = await repository.deleteDocument(
      BaseRequestDTO(payload: document.toJson()),
    );
    return res.success ? res.data : null;
  }

  Future<void> setPrimary(
    int index, {
    required Function(Document documents) callBackUpdate,
  }) async {
    showConfirmAlertDialog(
      message: 'Mark ${state.data?[index].info} as primary photo?',
      callBack: (agree) async {
        if (!agree || state.data == null) return;
        final updatedList = List<Document>.from(state.data!);
        for (int i = 0; i < updatedList.length; i++) {
          updatedList[i] = updatedList[i].copyWith(isPrimary: i == index);
          if (updatedList[i].isPrimary == true) {
            callBackUpdate(updatedList[i]);
          }
        }
        emit(state.copyWith(data: updatedList));
      },
    );
  }

  Future<void> handleRemove(int index) async {
    if (state.data != null && state.data!.isEmpty) return;
    showConfirmAlertDialog(
      message: 'Delete ${state.data?[index].info}?',
      callBack: (agree) async {
        if (agree) {
          try {
            final currentList = List<Document>.from(state.data ?? []);
            if (index < 0 || index >= currentList.length) return;

            currentList.removeAt(index);
            emit(state.copyWith(data: currentList));

            if (currentList.isNotEmpty) {
              final nextIndex = index >= currentList.length
                  ? currentList.length - 1
                  : index;
              await Future.delayed(const Duration(milliseconds: 150));

              await pageController.animateToPage(
                nextIndex,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic,
              );
            } else {
              Navigator.of(context).pop();
            }
          } catch (e) {
            debug(e);
          }
        }
      },
    );
    return;
  }

  void openPreviewDocument({
    int index = 0,
    Function(Document? documents)? callBackUpdate,
  }) {
    pageController = PageController(initialPage: index);
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => BlocProvider.value(
          value: this,
          child: _FullScreenGallery(
            controller: pageController,
            initialIndex: index,
            callBackUpdate: callBackUpdate,
            cubit: this,
          ),
        ),
      ),
    );
  }
}

class _FullScreenGallery extends StatefulWidget {
  final int initialIndex;
  final DocumentCubit cubit;
  final Function(Document? documents)? callBackUpdate;
  final PageController controller;

  const _FullScreenGallery({
    required this.initialIndex,
    this.callBackUpdate,
    required this.cubit,
    required this.controller,
  });

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery>
    with AutomaticKeepAliveClientMixin {
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<DocumentCubit, DocumentState>(
      builder: (context, state) {
        final documents = state.data ?? [];
        if (documents.isEmpty) {
          return const SizedBox.shrink();
        }

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              PageView.builder(
                controller: widget.controller,
                itemCount: documents.length,
                onPageChanged: (page) => setState(() => index = page),
                itemBuilder: (_, i) => InteractiveViewer(
                  child: Center(
                    child: AppCacheImage(
                      image: documents[i].imageUrl!,
                      fit: BoxFit.fitWidth,
                      iconSize: 50,
                      onError: Utils.getFileIcon(documents[i].type),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                right: 5,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 28),
                  onPressed: () => context.goBack(),
                ),
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlurButton(
                onClick: () => widget.cubit.setPrimary(
                  index,
                  callBackUpdate: widget.callBackUpdate!,
                ),
                icon: AppSvg.primary,
                size: 55,
                blurColor: Colors.white.withOpacitySafe(0.5),
                iconColor: context.primaryColor,
              ),
              Box.s16,
              BlurButton(
                onClick: () => widget.cubit.handleRemove(index),
                icon: AppSvg.delete,
                size: 55,
                blurColor: Colors.white.withOpacitySafe(0.5),
                iconColor: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
