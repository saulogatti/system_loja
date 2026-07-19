class BackupModel {

  BackupModel({required String nameBackup, required this.date})
    : fileName = _maskBackup + nameBackup;
  static const String _maskBackup = 'backup_';
  final String fileName;
  final DateTime date;

  String getFullFileName() => '${fileName}_${date.millisecondsSinceEpoch}.zip';
}
