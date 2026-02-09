import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract interface class ICategoryRepository {
  Future<ResultStatus<int, String>> createCategory({
    required String name,
    String? description,
  });
  Future<ResultStatus<bool, String>> deleteCategory(int id);
  Future<ResultStatus<List<Category>, String>> getAllCategories();
  Future<ResultStatus<Category, String>> getCategoryById(int id);
  Future<ResultStatus<Category, String>> getCategoryByName(String name);
  Future<bool> isCategoryInUse(int categoryId);
  Future<ResultStatus<bool, String>> updateCategory({
    required int id,
    required String name,
    String? description,
  });
}
