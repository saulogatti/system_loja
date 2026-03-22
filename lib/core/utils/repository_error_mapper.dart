import 'dart:convert';

/// Utilitário para mensagens de erro exibíveis na UI a partir de falhas
/// capturadas nos repositórios.
///
/// **Convenção do projeto**
/// - Repositórios (`lib/domain/repository/`): usam `try/catch` em torno de
///   I/O, Drift e parse; **não** propagam exceção para BLoC/Cubit; retornam
///   [ResultStatus.error] com texto obtido via [mensagemErroRepositorio] quando
///   fizer sentido.
/// - Apresentação (`lib/screens/`): **não** envolve chamadas ao repositório
///   em `try/catch`; usa `when` ou `switch` em [ResultStatus] e emite estado
///   de erro com a mensagem já tratada.
/// - `try/catch` na UI fica reservado a operações locais (ex.: seletor de
///   arquivo, escrita em [File]) que não passam pelo contrato do repositório.
String mensagemErroRepositorio(Object erro, {String contexto = ''}) {
  if (erro is FormatException) {
    return erro.message;
  }
  if (erro is JsonUnsupportedObjectError) {
    return 'Dados JSON inválidos ou não suportados.';
  }
  if (erro is TypeError) {
    return 'Formato de dados incompatível: $erro';
  }
  final prefix = contexto.isEmpty ? '' : '$contexto: ';
  return '$prefix$erro';
}
