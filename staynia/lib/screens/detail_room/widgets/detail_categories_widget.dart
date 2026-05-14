import 'package:flutter/material.dart';
import 'package:staynia/components/container/container_body.dart';
import 'package:staynia/components/filter/option_filter.dart';
import 'package:staynia/components/widgets/facility_icon.dart';
import 'package:staynia/core/constants/constants.dart';
import 'package:staynia/data/entity/model/category.dart';

class DetailCategoriesWidget extends StatelessWidget {
  final List<Category> categories;
  const DetailCategoriesWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return ContainerBody(
      child: Column(
        children: [
          Box.s16,
          OptionFilter(
            grid: 2,
            aspectRatio: 1.4,
            widgetItems: [
              ...(categories).asMap().entries.map((item) {
                return FacilityIcon(
                  svg: item.value.icon!,
                  label: item.value.description!,
                  size: 40,
                  color: Colors.black,
                  isAutoSizeText: false,
                  iconSize: 36,
                );
              }),
            ],
          ),
          Box.s16,
        ],
      ),
    );
  }
}
