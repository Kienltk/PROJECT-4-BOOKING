import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/title_column_content.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/dialog/app_bottom_sheet.dart';
import 'package:staynia/core/utils/utils.dart';
import 'package:staynia/data/entity/model/room.dart';
import 'package:staynia/extension/app_extension.dart';

class CustomRenderHtmlPreview extends StatelessWidget {
  final String html;
  final double collapsedHeight;
  final Room? room;

  const CustomRenderHtmlPreview({
    super.key,
    required this.html,
    this.room,
    this.collapsedHeight = 120,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRect(
          child: Stack(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: collapsedHeight,
                  minHeight: collapsedHeight,
                ),
                child: Html(
                  data: Utils.cleanHtml(html),
                  onAnchorTap: (url, _, __) async {
                    if (url == null) return;
                    Utils.openSmartLink(url);
                  },
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 100,
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacitySafe(0.0),
                          Colors.white.withOpacitySafe(0.2),
                          Colors.white,
                          Colors.white,
                        ],
                        stops: [0.0, 0.4, 1.0, 1.0],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              AppBottomSheet.showAppBottomSheet(
                context: context,
                child: ContainerBody(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (room != null) ...[
                        TitleColumnContent(
                          title: room?.title ?? '',
                          text: room?.subTitle,
                          fontSize: 25,
                        ),
                        Box.s10,
                      ],
                      Html(
                        data: Utils.cleanHtml(html),
                        onAnchorTap: (url, _, __) async {
                          if (url == null) return;
                          Utils.openSmartLink(url);
                        },
                      ),
                      Box.s16,
                    ],
                  ),
                ),
              );
            },
            child: Text('Read more...', style: TextStyle(fontSize: 12)),
          ),
        ),
      ],
    );
  }
}
