import 'package:flutter/material.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/core/theme/custom_theme.dart';
import 'package:staynia/data/entity/model/category.dart';

class CategoryFilter extends StatefulWidget {
  const CategoryFilter({super.key, this.categories});
  final List<Category>? categories;

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.categories == null) {
      return SizedBox.shrink();
    }
    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categories?.length,
        padding: EdgeInsets.only(bottom: 18),
        itemBuilder: (context, index) {
          final item = widget.categories?[index];
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? primaryColor800 : Colors.white,
                borderRadius: BorderRadius.circular(defaultBorderRadious),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Text(
                    item?.name ?? '-',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.white : Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
