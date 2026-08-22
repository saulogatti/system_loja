/// Metadados de um arquivo de backup compactado.
///
/// {@category dados}
/// {@subCategory Sistema}
///
/// Nomeia o ZIP; a persistência principal da loja continua no Drift.
class BackupModel {

  BackupModel({required String nameBackup, required this.date})
    : fileName = _maskBackup + nameBackup;
  static const String _maskBackup = 'backup_';
  /// Prefixo mais o nome informado na criação.
  final String fileName;
  /// Data usada no sufixo do arquivo.
  final DateTime date;

  /// Monta o nome completo do ZIP com timestamp.
  String getFullFileName() => '${fileName}_${date.millisecondsSinceEpoch}.zip';
}
