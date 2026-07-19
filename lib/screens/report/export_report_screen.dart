import 'package:flutter/material.dart';
import 'package:system_loja/screens/widgets/report_widget.dart';

class ExportReportScreen extends StatefulWidget {
  const ExportReportScreen({super.key});

  @override
  State<StatefulWidget> createState() => ExportReportScreenState();
}

class ExportReportScreenState extends State<ExportReportScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Exportar Relatório')),
      body: Column(
        children: [
          Expanded(
            child: ReportSelector(
              hasData: true,
              onAction: (action) async {
                switch (action) {
                  case ReportAction.shareCsv:
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Exportar CSV')));
                  case ReportAction.sharePdf:
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Compartilhar PDF')));
                  case ReportAction.printPdf:
                    // Implementar impressão PDF
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Imprimir PDF')));
                }
              },
            ),
          ),
        ],
      ),
    );
}
