import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:staynia/extension/theme_extension.dart';

class AgreementContent extends StatelessWidget {
  const AgreementContent({
    super.key,
    required this.title,
    required this.subTitle,
    this.agree,
    required this.agreeOnClick,
    required this.subTitleOnClick,
    this.subTitle2OnClick,
    this.subtitle2,
    this.title2,
  });
  final bool? agree;
  final String title, subTitle;
  final String? subtitle2, title2;
  final Function(bool?)? agreeOnClick;
  final VoidCallback subTitleOnClick;
  final VoidCallback? subTitle2OnClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Transform.scale(
                scale: 1.3,
                child: Checkbox(
                  value: agree,
                  onChanged: agreeOnClick,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  side: const BorderSide(color: Colors.grey, width: 1.5),
                  checkColor: Colors.white,
                  activeColor: context.primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.black),
                  children: [
                    TextSpan(
                      text: '$title ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: ' $subTitle',
                      style: TextStyle(
                        color: context.primaryColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () => subTitleOnClick(),
                    ),
                    if (subtitle2 != null) ...[
                      TextSpan(
                        text: '$title2 ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: ' $subtitle2',
                        style: TextStyle(
                          color: context.primaryColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () => subTitle2OnClick!(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
