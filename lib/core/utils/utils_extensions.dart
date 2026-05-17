import 'package:system_loja/core/models/default/default_object.dart';

extension MapId on Map<int, DefaultObject> {
  int get novoId {
    if (isEmpty) return 1;
    return keys.reduce((a, b) => a > b ? a : b) + 1;
  }
}

/// Extensão para formatação de preços
extension PriceFormatter on double {
  /// Formata o preço no padrão brasileiro (R$ XX.XX)
  String toFormattedPrice() {
    return 'R\$ ${toStringAsFixed(2)}';
  }
}
