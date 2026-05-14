import 'package:flutter/material.dart';
import 'package:staynia/components/button/on_click_button.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/utils/utils.dart';
import 'package:staynia/extension/theme_extension.dart';

class MultyColumContent extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final double padding;
  final double paddingTop;
  final String? title;
  final VoidCallback? onClick;
  const MultyColumContent({
    super.key,
    required this.data,
    this.padding = 12,
    this.paddingTop = 20,
    this.onClick,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ...data.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final rawValue = item['value'];
          final value = (rawValue == null || rawValue.toString().trim().isEmpty)
              ? '-'
              : rawValue.toString().trim();
          VoidCallback? valueClick;
          TextStyle? valueStyle;
          if (Utils.checkLink(value)) {
            valueStyle = TextStyle(
              color: context.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: context.primaryColor,
            );
            valueClick = () {
              Utils.openSmartLink(value);
            };
          }
          return Padding(
            padding: EdgeInsets.only(top: index == 0 ? paddingTop : 0),
            child: ColumnContent(
              onClick: onClick,
              title: item['title'] ?? '-',
              value: value,
              padding: (index == data.length - 1) ? 0 : padding,
              valueStyle: valueStyle ?? item['style'] as TextStyle?,
              valueOnClick: valueClick ?? item['onClick'] as VoidCallback?,
            ),
          );
        }),
      ],
    );
  }
}

class ColumnContent extends StatelessWidget {
  final String title;
  final String? value;
  final TextStyle? valueStyle;
  final VoidCallback? onClick, valueOnClick;
  final double padding;
  const ColumnContent({
    super.key,
    required this.title,
    this.value,
    this.valueOnClick,
    this.onClick,
    this.valueStyle,
    this.padding = 35,
  });

  @override
  Widget build(BuildContext context) {
    return OnClickButton(
      onClick: onClick ?? () {},
      child: Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.bodySmall!.copyWith(fontSize: 13),
            ),
            Box.s6,
            OnClickButton(
              onClick: valueOnClick ?? () {},
              child: Text(
                (value != null && value != '') ? value! : '-',
                style: valueStyle != null
                    ? valueStyle!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      )
                    : const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
