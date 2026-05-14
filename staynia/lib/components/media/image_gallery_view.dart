import 'package:flutter/material.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/components/media/app_cache_image.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/dialog/app_dialog.dart';
import 'package:staynia/core/utils/utils.dart';
import 'package:staynia/data/entity/model/document.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/providers/manager/document/document_cubit.dart';

class ImageGalleryView extends StatelessWidget {
  final List<Document>? documents;
  final bool isEdit;
  final DocumentCubit? documentCubit;
  final Widget? topWidget;
  final Function(List<Document>? documents)? callBack;
  final Function(Document? documents)? callBackUpdate;

  const ImageGalleryView({
    super.key,
    this.documents,
    this.callBackUpdate,
    this.isEdit = false,
    this.topWidget,
    this.documentCubit,
    this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    final originalDocs = documents ?? [];
    final docs = [...originalDocs]
      ..sort((a, b) {
        if (a.isPrimary == b.isPrimary) return 0;
        return a.isPrimary == true ? -1 : 1;
      });

    if (docs.isEmpty && !isEdit) return const SizedBox.shrink();

    final showImages = isEdit ? docs : docs.take(3).toList();
    final remaining = isEdit
        ? 0
        : (docs.length - 3).clamp(0, double.infinity).toInt();
    final totalItems = isEdit ? showImages.length + 1 : showImages.length;

    if (isEdit) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (topWidget != null) ...[topWidget!, Box.s4],
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: List.generate(totalItems, (index) {
              final isAddButton = index == totalItems - 1;
              if (isAddButton) {
                return SizedBox(
                  width: docs.isEmpty ? context.sizeWidth * 0.28 : 100,
                  height: 100,
                  child: OnClickButton(
                    onClick: () =>
                        documentCubit?.handleFile(callBack: callBack),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          defaultBorderRadious,
                        ),
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: const Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: AppAssetIcon(AppSvg.camera, size: 30),
                        ),
                      ),
                    ),
                  ),
                );
              }

              final document = showImages[index];
              final imageUrl = document.imageUrl ?? '';

              final originalIndex = originalDocs.indexWhere(
                (d) => d.id == document.id,
              );
              final previewIndex = originalIndex >= 0 ? originalIndex : index;

              return SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  children: [
                    OnClickButton(
                      onClick: () => documentCubit?.openPreviewDocument(
                        index: previewIndex,
                        callBackUpdate: callBackUpdate,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacitySafe(0.5),
                          ),
                          borderRadius: BorderRadius.circular(
                            defaultBorderRadious,
                          ),
                        ),
                        child: AppCacheImage(
                          image: imageUrl,
                          radius: defaultBorderRadious,
                          onError: Utils.getFileIcon(document.type),
                        ),
                      ),
                    ),
                    if (document.isPrimary == true)
                      const Positioned(
                        top: 4,
                        right: 4,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.red,
                          size: 26,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topWidget != null) ...[topWidget!, Box.s4],
        Row(
          children: List.generate(totalItems, (index) {
            final document = showImages[index];
            final isLastWithMore = index == 2 && remaining > 0;
            final imageUrl = document.imageUrl ?? '';
            final originalIndex = originalDocs.indexWhere(
              (d) => d.id == document.id,
            );
            final previewIndex = originalIndex >= 0 ? originalIndex : index;

            return Expanded(
              child: Stack(
                children: [
                  Opacity(
                    opacity: isLastWithMore ? 0.4 : 1,
                    child: OnClickButton(
                      onClick: () => AppDialog.openPreviewDocument(
                        context: context,
                        index: previewIndex,
                        documents: originalDocs,
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacitySafe(0.5),
                          ),
                          borderRadius: BorderRadius.circular(
                            defaultBorderRadious,
                          ),
                        ),
                        child: AppCacheImage(
                          image: imageUrl,
                          radius: defaultBorderRadious,
                          onError: Utils.getFileIcon(document.type),
                        ),
                      ),
                    ),
                  ),
                  if (isLastWithMore)
                    Positioned.fill(
                      child: Center(
                        child: Text(
                          '+$remaining',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}
