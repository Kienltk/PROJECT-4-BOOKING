import 'dart:async';

import 'package:staynia/core/base/bloc/base_cubit.dart';
import 'package:staynia/data/entity/model/auth_token.dart';
import 'package:staynia/data/entity/model/base_request_dto_model.dart';
import 'package:staynia/data/repository/user_repository.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/providers/manager/user/user_event.dart';
import 'package:staynia/store/auth_store.dart';

class RefreshTokenCubit extends BaseCubit<void, UserRepository> {
  final UserBloc userBloc;
  Timer? _timer;
  RefreshTokenCubit(UserRepository repository, this.userBloc)
    : super(null, repository);

  @override
  Future<void> onInit({dynamic arg}) async {}

  Future<void> refreshToken() async {
    AuthToken? authToken = await AuthStore.getAuthToken();
    if (authToken == null) return;
    try {
      final res = await repository.refreshToken(
        BaseRequestDTO(payload: {"refreshToken": authToken.refreshToken}),
      );
      debug(res);
      if (res.success) {
        final newToken = (res.data?['token'] as AuthToken).copyWith(
          createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        );
        userBloc.add(SaveUserOnRefresh(res.data?['user'], newToken));
        _scheduleAutoRefresh(newToken);
      }
    } catch (e) {
      debug("CATCH ===> ");
      debug(e);
    }
  }

  Future<void> startAutoRefresh() async {
    final token = await AuthStore.getAuthToken();
    if (token != null) {
      debug('START AUTO REFRESH TOKEN');
      _scheduleAutoRefresh(token);
    }
  }

  void _scheduleAutoRefresh(AuthToken token) {
    _timer?.cancel();

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000; 
    final created = token.createdAt; 
    final expirationInSeconds = token.expiration! * 60;
    final refreshBefore = expirationInSeconds > 180 ? 180 : 10;

    int delay = created + expirationInSeconds - now - refreshBefore;
    if (delay < 5) delay = 5; 

    debug(
      'next refresh in $delay seconds (${(delay / 60).toStringAsFixed(1)} phút)',
    );
    _timer = Timer(Duration(seconds: delay), refreshToken);
  }

  void cancelAutoRefresh() {
    _timer?.cancel();
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    super.close();
  }
}
