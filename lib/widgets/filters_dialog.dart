import 'package:flutter/material.dart';

class FiltersDialog extends StatelessWidget {
  final List<String> allStyles;
  final List<String> selectedStyles;
  final ValueChanged<List<String>> onSelectedStylesChanged;

  FiltersDialog({
    required this.allStyles,
    required this.selectedStyles,
    required this.onSelectedStylesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Filter by Dance Styles"),
      content: SingleChildScrollView(
        child: Column(
          children: allStyles.map((style) {
            return CheckboxListTile(
              title: Text(style),
              value: selectedStyles.contains(style),
              onChanged: (bool? selected) {
                final updatedStyles = List<String>.from(selectedStyles);
                if (selected == true) {
                  updatedStyles.add(style);
                } else {
                  updatedStyles.remove(style);
                }
                onSelectedStylesChanged(updatedStyles);
              },
            );
          }).toList(),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text("Close")),
      ],
    );
  }
}
