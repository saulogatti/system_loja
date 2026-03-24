import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:system_loja/screens/widgets/report_widget.dart';

class ReportScreen extends StatefulWidget {
  @Preview()
  const ReportScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Relatório')),
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Compartilhar PDF')));
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
