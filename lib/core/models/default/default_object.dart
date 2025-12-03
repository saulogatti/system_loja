/// Objeto padrão com ID único.
abstract class DefaultObject {
  final int id;

  DefaultObject({required this.id});

  Map<String, dynamic> toJson();
}
