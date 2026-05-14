import 'package:flutter/material.dart';

abstract class PaginationController {
  ScrollController get scrollController;
  ValueNotifier<bool> get loadingMoreNotifier;
  Future<void> onRefresh();
}
