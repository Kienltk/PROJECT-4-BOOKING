import 'package:flutter/material.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/components/media/app_asset_icon.dart';
import 'package:staynia/core/constants/app_svg.dart';
import 'package:staynia/extension/app_extension.dart';
import 'package:staynia/extension/context_extension.dart';
import 'package:staynia/extension/navigator_extension.dart';

class CustomSliverAppBar extends StatefulWidget {
  final String leftSvgPath;
  final List<Widget>? actions;
  final VoidCallback? leftOnClick;
  final Color leftSvgColor;
  final ScrollController? controller;
  final Widget? flexibleSpaceWidget;
  final double? expandedHeight;
  final String? title;
  final Function(Color)? callbackColor;

  const CustomSliverAppBar({
    super.key,
    this.actions,
    this.controller,
    this.expandedHeight,
    this.leftOnClick,
    this.title,
    this.callbackColor,
    this.flexibleSpaceWidget,
    this.leftSvgPath = AppSvg.arrowLeft,
    this.leftSvgColor = Colors.white,
  });

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  Color _color = Colors.white;
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    widget.controller?.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.controller != null && widget.controller!.hasClients && mounted) {
      double offset = widget.controller!.offset;
      if (offset >
          (widget.expandedHeight != null ? widget.expandedHeight! - 60 : 60)) {
        setState(() {
          _color = Colors.black;
          _showTitle = true;
        });
      } else {
        setState(() {
          _color = widget.leftSvgColor;
          _showTitle = false;
        });
      }
      if (widget.callbackColor != null) {
        widget.callbackColor!(_color);
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: widget.expandedHeight,
      pinned: true,
      toolbarHeight: kToolbarHeight - 5,
      backgroundColor: Colors.white.withOpacitySafe(0.93),
      centerTitle: true,
      leading: OnClickButton(
        onClick: () => context.goBack(),
        child: Container(
          margin: const EdgeInsets.only(bottom: 5, right: 2),
          padding: const EdgeInsets.all(6),
          child: AppAssetIcon(widget.leftSvgPath, color: _color),
        ),
      ),
      bottom: _showTitle
          ? const PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(color: Color.fromARGB(255, 217, 217, 217)),
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: Stack(
          fit: StackFit.expand,
          children: [
            widget.flexibleSpaceWidget ?? const SizedBox.shrink(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: kToolbarHeight + MediaQuery.of(context).padding.top,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: _showTitle
                        ? [Colors.transparent]
                        : [
                            Colors.white,
                            Colors.white.withOpacitySafe(0.6),
                            Colors.white.withOpacitySafe(0.3),
                            Colors.white.withOpacitySafe(0.1),
                            Colors.white.withOpacitySafe(0.0),
                            Colors.white.withOpacitySafe(0.0),
                          ],
                  ),
                ),
              ),
            ),
          ],
        ),
        title: _showTitle
            ? SizedBox(
                width: context.sizeWidth * 0.4,
                child: Text(
                  widget.title ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )
            : null,
        centerTitle: true,
      ),
      actions: widget.actions,
    );
  }
}
