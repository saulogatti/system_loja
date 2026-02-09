import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract interface class IProductRepository {
  Future<ResultStatus<bool, String>> deleteProduct(int id);
  Future<ResultStatus<List<Product>, String>> fetchProducts();
  Future<ResultStatus<Product, String>> findByCode(int codigo);
  Future<String> generateProductCode();
  Future<ResultStatus<bool, String>> saveProduct(Product product);
  Future<ResultStatus<bool, String>> updateProduct(Product product);
  Future<ResultStatus<bool, String>> validateProductCode(String code);
}
