
import 'package:flutter/material.dart';

class TitleWithAction extends StatelessWidget {
  const TitleWithAction({
    super.key,
    required this.title,
    this.subTitle,
    this.onClick,
  });
  final String title;
  final String? subTitle;
  final VoidCallback? onClick;
   


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          if (onClick != null)
            TextButton(
              onPressed: onClick,
              child: Text(
                subTitle ?? 'See All',
                style: TextStyle(fontSize: 12.3),
              ),
            ),
        ],
      ),
    );
  }
}
