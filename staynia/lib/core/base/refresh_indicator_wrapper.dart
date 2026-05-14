import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:staynia/components/animation/custom_gif_animation.dart';
import 'package:staynia/components/animation/loading_spinner.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/base/pagination_controller.dart';
import 'package:staynia/core/constants/app_gif.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/core/theme/custom_theme.dart';
import 'package:staynia/extension/theme_extension.dart';

class RefreshIndicatorWrapper<T extends PaginationController>
    extends StatelessWidget {
  final Widget child;
  final Color? refreshColor;
  final T controller;
  const RefreshIndicatorWrapper({
    super.key,
    required this.child,
    required this.controller,
    this.refreshColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final scrollable = SingleChildScrollView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: child,
          ),
        );

        return Stack(
          children: [
            CustomRefreshIndicator(
              onRefresh: controller.onRefresh,
              trigger: IndicatorTrigger.leadingEdge,
              triggerMode: IndicatorTriggerMode.onEdge,
              child: scrollable,
              builder: (context, scrollChild, refreshController) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    scrollChild,
                    if (refreshController.isLoading ||
                        refreshController.isDragging)
                      Positioned(
                        top: 20,
                        child: Transform.scale(
                          scale: refreshController.value.clamp(0.6, 1.0),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: refreshController.isLoading
                                ? BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [bShadow()],
                                  )
                                : null,
                            child: refreshController.isLoading
                                ? LoadingSpinner.buildSpinner(
                                    spinColor: context.primaryColor,
                                    size: 28,
                                  )
                                : AppAssetIcon(
                                    AppSvg.location,
                                    size: 40,
                                    color: refreshColor,
                                  ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            ValueListenableBuilder<bool>(
              valueListenable: controller.loadingMoreNotifier,
              builder: (_, loading, _) {
                if (!loading) return const SizedBox();
                return const Positioned(
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: CustomGifAnimation(
                    assetGif: AppGifs.loading,
                    size: 0.5,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
