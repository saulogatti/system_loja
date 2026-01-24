// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dao.dart';

// ignore_for_file: type=lint
mixin _$CategoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $CategoriesRecordsTable get categoriesRecords => attachedDatabase.categoriesRecords;
  CategoryDaoManager get managers => CategoryDaoManager(this);
}

class CategoryDaoManager {
  final _$CategoryDaoMixin _db;
  CategoryDaoManager(this._db);
  $$CategoriesRecordsTableTableManager get categoriesRecords =>
      $$CategoriesRecordsTableTableManager(
        _db.attachedDatabase,
        _db.categoriesRecords,
      );
}
