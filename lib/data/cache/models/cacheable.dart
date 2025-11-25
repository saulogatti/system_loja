import 'package:flutter/foundation.dart';

/// Define o objeto que pode ser armazenado em cache
abstract class Cacheable {
  String get cacheKey;
  Factory<Cacheable> fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
