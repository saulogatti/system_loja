import 'package:flutter/material.dart';
import 'package:system_loja/screens/widgets/report_widget.dart';

class ExportReportScreen extends StatefulWidget {
  const ExportReportScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ExportReportScreenState();
  }
}

class ExportReportScreenState extends State<ExportReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exportar Relatório')),
      body: Column(
        children: [
          Expanded(
            child: ReportSelector(
              hasData: true,
              onAction: (action) async {
                switch (action) {
                  case ReportAction.shareCsv:
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Exportar CSV')));
                    break;
                  case ReportAction.sharePdf:
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Exportar PDF')));
                    break;
                  case ReportAction.printPdf:
                    // Implementar impressão PDF
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Imprimir PDF')));
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
