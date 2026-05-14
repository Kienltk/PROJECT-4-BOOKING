import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/core/base/pagination_controller.dart';
import 'package:staynia/core/log.dart';
import 'package:staynia/data/entity/model/user.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/router/application_router.dart';
import 'package:staynia/service/loading_service.dart';
import 'package:staynia/service/notification_service.dart';

abstract class BaseCubit<S, R> extends Cubit<S>
    implements PaginationController {
  final R repository;

  BaseCubit(super.initialState, this.repository) {
    scrollController.addListener(_onScroll);
  }

  @override
  final ScrollController scrollController = ScrollController();
  @override
  final ValueNotifier<bool> loadingMoreNotifier = ValueNotifier(false);

  int page = 0;
  int limit = 25;
  bool lastPage = false;
  bool hasFetched = false;
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;
  BuildContext get context => navigatorKey.currentContext!;
  User get user => context.read<UserBloc>().user;

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 150) {
      loadMore();
    }
  }

  Future<void> get() async {
    page = 0;
    lastPage = false;
    hasFetched = false;
    try {
      await onInit();
      hasFetched = true;
    } catch (e) {
      debug(e);
    } finally {
      hideLoading();
    }
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || lastPage || !hasFetched) {
      return;
    }
    _isLoadingMore = true;
    loadingMoreNotifier.value = true;
    try {
      await onLoadMore();
    } catch (e) {
      debug(e);
    } finally {
      _isLoadingMore = false;
      loadingMoreNotifier.value = false;
    }
  }

  @override
  Future<void> onRefresh() async {
    page = 0;
    lastPage = false;
    hasFetched = false;
    await get();
  }

  Future<void> onInit({dynamic arg}) async {}
  Future<void> onLoadMore() async {}
  Future<void> showLoading() async => LoadingService.show();
  Future<void> hideLoading() async => LoadingService.hide();
  void debug(e) => Log.d(e, name: runtimeType.toString());

  void showBottomToast(
    String message, {
    Duration duration = const Duration(seconds: 3),
    bool isWarning = false,
  }) {
    NotificationService.showBottomToast(
      message,
      duration: duration,
      isWarning: isWarning,
    );
  }

  void showNotification(
    String message, {
    String? title,
    String? image,
    bool enableSlideOff = true,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClick,
  }) {
    NotificationService.showNotification(
      message,
      title: title,
      enableSlideOff: enableSlideOff,
      duration: duration,
      onClick: onClick,
    );
  }

  Future<void> showAlert({String? code, String? message}) async {
    // ignore: unused_result
    await showAlertDialog(
      context: context,
      title: code ?? "Notification",
      message: message ?? "Lỗi. Xin vui lòng thử lại sau",
      actions: [AlertDialogAction(key: null, label: "Close")],
    );
  }

  Future<void> showConfirmModalActionSheet({
    String? title,
    String? buttonContent,
    String? buttonContent1,
    required String message,
    required Function(bool isAgree) callBack,
  }) async {
    bool option = buttonContent1 != null;
    await showModalActionSheet<int>(
      context: context,
      title: title ?? 'Notification',
      cancelLabel: 'Close',
      message: message,
      actions: [
        SheetAction(
          key: 1,
          label: buttonContent ?? 'Confirm',
          isDefaultAction: !option,
          isDestructiveAction: !option,
        ),
        if (option)
          SheetAction(
            key: 2,
            label: buttonContent1,
            isDefaultAction: option,
            isDestructiveAction: option,
          ),
      ],
      onPopInvokedWithResult: (_, result) async {
        if (result == null) return;
        Future.microtask(() {
          switch (result) {
            case 1:
              callBack(true);
            case 2:
              callBack(false);
          }
        });
      },
    );
  }

  Future<void> showConfirmAlertDialog({
    String? title,
    String? buttonLeft,
    String? buttonRight,
    required String message,
    required Function(bool isAgree) callBack,
  }) async {
    await showAlertDialog<bool>(
      context: context,
      title: title ?? 'Notification',
      message: message,
      actions: [
        AlertDialogAction(
          key: false,
          label: buttonLeft ?? 'Cancel',
          isDestructiveAction: true,
        ),
        AlertDialogAction(
          key: true,
          label: buttonRight ?? 'Confirm',
          isDefaultAction: true,
        ),
      ],
      onPopInvokedWithResult: (_, result) {
        if (result != null && result) {
          WidgetsBinding.instance.addPostFrameCallback((_) => callBack(true));
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) => callBack(false));
        }
      },
    );
  }

  Future<void> delay({int seconds = 5}) async =>
      await Future.delayed(Duration(seconds: seconds));

  @override
  Future<void> close() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    loadingMoreNotifier.dispose();
    return super.close();
  }
}
