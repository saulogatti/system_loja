class BackupModel {
  static const String _maskBackup = 'backup_';
  final String fileName;
  final DateTime date;

  BackupModel({required String nameBackup, required this.date})
    : fileName = _maskBackup + nameBackup;

  String getFullFileName() => '${fileName}_${date.millisecondsSinceEpoch}.zip';
}
