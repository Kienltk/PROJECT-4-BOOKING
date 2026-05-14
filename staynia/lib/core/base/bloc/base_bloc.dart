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

abstract class BaseBloc<E, S, R> extends Bloc<E, S>
    implements PaginationController {
  final R? repository;

  BaseBloc(super.initialState, [this.repository]) {
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
    _isLoadingMore = false;
    page = 0;
    lastPage = false;
  }

  Future<void> onLoadMore() async {}
  void showLoading() => LoadingService.show();
  void hideLoading() => LoadingService.hide();
  void debug(e) => Log.d(e, name: runtimeType.toString());
  Future<void> delay({int seconds = 6}) async =>
      await Future.delayed(Duration(seconds: seconds));

  void showBottomToast(
    String message, {
    int type = 1,
    Duration duration = const Duration(seconds: 4),
    bool isWarning = false,
  }) {
    NotificationService.showBottomToast(
      message,
      duration: duration,
      type: type,
      isWarning: isWarning,
    );
  }

  void showNotification(
    String message, {
    String? title,
    String? image,
    int type = 1,
    bool enableSlideOff = true,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onClick,
  }) {
    NotificationService.showNotification(
      message,
      title: title,
      type: type,
      enableSlideOff: enableSlideOff,
      duration: duration,
      onClick: onClick,
    );
  }

  Future<void> showErrorAlert(String errorCode, message) async {
    // ignore: unused_result
    await showAlertDialog(
      context: context,
      title: errorCode,
      message: message,
      actions: [AlertDialogAction(key: null, label: "Close")],
    );
  }

  @override
  Future<void> close() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    loadingMoreNotifier.dispose();
    return super.close();
  }
}
