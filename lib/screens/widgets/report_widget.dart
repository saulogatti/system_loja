import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview()
Widget previewReportSelector() {
  return Center(
    child: ReportSelector(hasData: false, onAction: (action) async {}),
  );
}

enum ReportAction { shareCsv, sharePdf, printPdf }

class ReportSelector extends StatelessWidget {
  final bool hasData;
  final Future<void> Function(ReportAction action) onAction;

  const ReportSelector({
    required this.hasData,
    required this.onAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<ReportAction>(
      onSelected: onAction,
      enabled: hasData,
      itemBuilder: (context) => const [
        PopupMenuItem(
          value: ReportAction.shareCsv,
          child: Text('Exportar CSV'),
        ),
        PopupMenuItem(
          value: ReportAction.sharePdf,
          child: Text('Compartilhar PDF'),
        ),
        PopupMenuItem(
          value: ReportAction.printPdf,
          child: Text('Imprimir PDF'),
        ),
      ],
      icon: const Icon(Icons.picture_as_pdf_outlined),
      tooltip: hasData
          ? 'Exportar relatório'
          : 'Cadastre itens para habilitar o relatório',
    );
  }
}
