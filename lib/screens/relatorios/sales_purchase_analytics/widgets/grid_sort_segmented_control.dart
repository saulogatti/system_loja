import 'package:flutter/material.dart';

enum GridSortOrder { recentes, antigos }

class GridSortSegmentedControl extends StatelessWidget {
  final GridSortOrder current;
  final ValueChanged<GridSortOrder> onChanged;

  const GridSortSegmentedControl({
    required this.current,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<GridSortOrder>(
      segments: const [
        ButtonSegment(
          value: GridSortOrder.recentes,
          label: Text('Recentes'),
          icon: Icon(Icons.schedule),
        ),
        ButtonSegment(
          value: GridSortOrder.antigos,
          label: Text('Antigos'),
          icon: Icon(Icons.history),
        ),
      ],
      selected: {current},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}
