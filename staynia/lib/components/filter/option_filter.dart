import 'package:flutter/material.dart';

class OptionFilter extends StatefulWidget {
  final int grid;
  final List<Widget> widgetItems;
  final double aspectRatio, spacing;

  const OptionFilter({
    required this.grid,
    required this.aspectRatio,
    required this.widgetItems,
    this.spacing = 10,
    super.key,
  });

  @override
  OptionFilterState createState() => OptionFilterState();
}

class OptionFilterState extends State<OptionFilter> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeBottom: true,
      removeTop: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.grid,
          crossAxisSpacing: widget.spacing,
          mainAxisSpacing: widget.spacing,
          childAspectRatio: widget.aspectRatio,
        ),
        itemCount: widget.widgetItems.length,
        itemBuilder: (context, index) {
          final item = widget.widgetItems[index];
          return item;
        },
      ),
    );
  }
}
