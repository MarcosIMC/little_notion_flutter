import 'package:flutter/material.dart';
import 'package:mini_notion/models/categories.dart';

class FilterChipWidget extends StatefulWidget {
  const FilterChipWidget({super.key});

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  Set<CategoriesEnum> _selectedCategory = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children:CategoriesEnum.values.map((category) {
        final isSelected = _selectedCategory.contains(category);
        return FilterChip(
            label: Text(category.name),
            selected: isSelected,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  _selectedCategory.add(category);
                } else {
                  _selectedCategory.remove(category);
                }
              });
            }
        );
      }).toList(),
    );
  }
}
