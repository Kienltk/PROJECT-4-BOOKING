import 'dart:io';

import 'package:flutter/material.dart';
import 'package:staynia/components/animation/loading_spinner.dart';
import 'package:staynia/components/app_bar/custom_app_bar.dart';
import 'package:staynia/components/widgets/custom_scaffold.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/core/injection.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/providers/manager/user/user_event.dart';

class FullScreenContent extends StatefulWidget {
  const FullScreenContent({
    super.key,
    this.title,
    this.subTitle,
    this.button,
    this.isOpenApp = false,
    this.showAppbar = false,
  });
  final String? title, subTitle;
  final Widget? button;
  final bool isOpenApp, showAppbar;

  @override
  State<FullScreenContent> createState() => _FullScreenContentState();
}

class _FullScreenContentState extends State<FullScreenContent> {
  @override
  void initState() {
    super.initState();
    if (widget.isOpenApp) {
      sl<UserBloc>().add(LoadUser());
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: widget.showAppbar
          ? const CustomAppBar(color: Colors.transparent)
          : null,
      noNeedUser: true,
      bodyBuilder: (_) => Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: BuildBottomContent(
              title: widget.title,
              subTitle: widget.subTitle,
              button: widget.button,
            ),
          ),
        ],
      ),
    );
  }
}

class BuildBottomContent extends StatelessWidget {
  const BuildBottomContent({super.key, this.title, this.subTitle, this.button});

  final String? title, subTitle;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.sizeWidth * 0.95,
        maxHeight: context.sizeHeight * 0.3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (title != null)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          if (subTitle != null) ...[
            const SizedBox(height: 16),
            Text(
              subTitle!,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall!.copyWith(),
            ),
          ],
          Box.height(16 * 2.5),
          button ??
              LoadingSpinner.buildSpinner(
                spinColor: Colors.black,
                type: Platform.isIOS ? 2 : 1,
                size: 0.2,
              ),
          Box.height(16),
        ],
      ),
    );
  }
}
