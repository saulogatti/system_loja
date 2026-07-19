import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum GridSortOrder { recentes, antigos }

class GridSortSegmentedControl extends StatelessWidget {

  const GridSortSegmentedControl({
    required this.current,
    required this.onChanged,
    super.key,
  });
  final GridSortOrder current;
  final ValueChanged<GridSortOrder> onChanged;

  @override
  Widget build(BuildContext context) => SegmentedButton<GridSortOrder>(
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<GridSortOrder>('current', current));
    properties.add(ObjectFlagProperty<ValueChanged<GridSortOrder>>.has('onChanged', onChanged));
  }
}
