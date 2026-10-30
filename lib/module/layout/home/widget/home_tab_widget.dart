import 'package:flutter/material.dart';

import '../../../../core/theme/color_palette.dart';
import '../../../../models/event_category.dart';

class HomeTabWidget extends StatelessWidget {
  final EventCategory eventCategory;
  final bool isSelected;

  const HomeTabWidget({
    super.key,
    required this.eventCategory,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? ColorPalette.white : ColorPalette.primaryColor,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: ColorPalette.white, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            eventCategory.eventCategoryIcon,
            color: isSelected ? ColorPalette.primaryColor : ColorPalette.white,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            eventCategory.eventCategoryName,
            style: theme.textTheme.titleMedium?.copyWith(
              color: isSelected ? ColorPalette.primaryColor : ColorPalette.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
