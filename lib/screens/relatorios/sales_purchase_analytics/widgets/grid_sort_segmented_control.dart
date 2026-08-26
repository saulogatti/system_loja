import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

enum GridSortOrder { recentes, antigos }

class GridSortSegmentedControl extends StatelessWidget {
  const GridSortSegmentedControl({required this.current, required this.onChanged, super.key});
  final GridSortOrder current;
  final ValueChanged<GridSortOrder> onChanged;

  @override
  Widget build(BuildContext context) => SegmentedButton<GridSortOrder>(
    segments: const [
      ButtonSegment(
        value: GridSortOrder.recentes,
        label: Text('Recentes'),
        icon: Icon(Icons.schedule),
        tooltip: 'Ordenar do mais recente para o mais antigo',
      ),
      ButtonSegment(
        value: GridSortOrder.antigos,
        label: Text('Antigos'),
        icon: Icon(Icons.history),
        tooltip: 'Ordenar do mais antigo para o mais recente',
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
