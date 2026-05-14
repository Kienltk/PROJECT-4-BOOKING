import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staynia/components/widgets/full_screen_content.dart';
import 'package:staynia/core/constants/app_image.dart';
import 'package:staynia/data/entity/model/user.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/theme_extension.dart';
import 'package:staynia/providers/manager/user/user_bloc.dart';
import 'package:staynia/providers/manager/user/user_state.dart';

class CustomScaffold extends StatefulWidget {
  final Widget? floatingActionButton, bottomNavigationBar;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final String backgroundImage;
  final bool removeLeft,
      removeTop,
      removeRight,
      removeBottom,
      extendBody,
      extendBodyBehindAppBar,
      noNeedUser,
      decor;
  final Widget Function(User? user)? bodyBuilder;
  const CustomScaffold({
    super.key,
    this.appBar,
    this.extendBody = false,
    this.noNeedUser = false,
    this.extendBodyBehindAppBar = false,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundImage = AppImage.backgroundGrey,
    this.backgroundColor,
    this.removeLeft = false,
    this.removeTop = true,
    this.decor = true,
    this.removeRight = false,
    this.removeBottom = false,
    this.bodyBuilder,
  });

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: widget.removeTop,
      removeBottom: widget.removeBottom,
      removeLeft: widget.removeLeft,
      removeRight: widget.removeRight,
      child: SizedBox.expand(
        child: Stack(
          children: [
            // Container(color: context.scaffoldBackgroundColor),
            // Positioned.fill(
            //   child: AppAssetImage(
            //     widget.backgroundImage,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: context.sizeHeight * 0.55,
              child: Container(
                decoration: widget.decor
                    ? const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(0, 120, 119, 119),
                            Color.fromARGB(117, 255, 255, 255),
                            Color.fromARGB(245, 255, 255, 255),
                            Colors.white,
                          ],
                          stops: [0.0, 0.4, 0.8, 1],
                        ),
                      )
                    : null,
              ),
            ),
            BlocBuilder<UserBloc, UserState>(
              builder: (_, state) {
                final user = state is Authenticated ? state.user : null;
                return Scaffold(
                  extendBody: widget.extendBody,
                  backgroundColor:
                      widget.backgroundColor ?? context.scaffoldBackgroundColor,
                  extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
                  appBar: widget.appBar,
                  body: Builder(
                    builder: (_) {
                      if (widget.noNeedUser && widget.bodyBuilder != null) {
                        return widget.bodyBuilder!(null);
                      } else if (!widget.noNeedUser &&
                          user != null &&
                          widget.bodyBuilder != null) {
                        return widget.bodyBuilder!(user);
                      } else {
                        return const FullScreenContent();
                      }
                    },
                  ),
                  floatingActionButton: widget.floatingActionButton,
                  bottomNavigationBar: widget.bottomNavigationBar,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
