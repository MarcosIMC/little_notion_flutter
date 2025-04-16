import 'package:flutter/material.dart';
import 'package:mini_notion/models/categories.dart';
import 'package:mini_notion/providers/categories_provider.dart';
import 'package:provider/provider.dart';

class FilterChipWidget extends StatefulWidget {
  const FilterChipWidget({super.key});

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);

    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children:CategoriesEnum.values.map((category) {
        final isSelected = categoriesProvider.contains(category);
        return FilterChip(
            label: Text(category.name),
            selected: isSelected,
            onSelected: (bool selected) {
              setState(() {
                if (selected) {
                  categoriesProvider.add(category);
                } else {
                  categoriesProvider.remove(category);
                }
              });
            }
        );
      }).toList(),
    );
  }
}
