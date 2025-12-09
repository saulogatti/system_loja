import 'package:freezed_annotation/freezed_annotation.dart';

/// Representa o resultado de uma operação com falha.
///
/// Contém o erro ocorrido durante a execução da operação.
/// Esta classe é uma subclasse de [OperationResult] e indica que
/// a operação não foi concluída com sucesso.
///
/// Tipo genérico:
/// - [R]: Tipo do resultado em caso de sucesso
/// - [E]: Tipo do erro em caso de falha
class OperationError<R, E> extends OperationResult<R, E> {
  /// O erro que ocorreu durante a operação.
  final E error;

  /// Cria uma instância de erro com o erro especificado.
  OperationError(this.error);
}

/// Representa o resultado de uma operação que pode ter sucesso ou falha.
///
/// Esta sealed class implementa o padrão Result para tratamento de erros
/// de forma type-safe. Use pattern matching com [when] ou verificações
/// de tipo com [isSuccessful] e [hasError] para lidar com os casos.
///
/// Tipos genéricos:
/// - [R]: Tipo do resultado em caso de sucesso
/// - [E]: Tipo do erro em caso de falha
///
/// Exemplo de uso:
/// ```dart
/// OperationResult<String, Exception> resultado = fazerOperacao();
/// resultado.when(
///   onSuccess: (valor) => print('Sucesso: $valor'),
///   onFailure: (erro) => print('Erro: $erro'),
/// );
/// ```
///
/// Ou usando getters:
/// ```dart
/// if (resultado.isSuccessful) {
///   final valor = resultado.asSuccess;
///   print('Sucesso: $valor');
/// } else {
///   final erro = resultado.asError;
///   print('Erro: $erro');
/// }
/// ```
sealed class OperationResult<R, E> {
  /// Construtor protegido para uso interno das subclasses.
  @protected
  OperationResult();

  /// Cria um resultado de falha com o erro especificado.
  ///
  /// Factory constructor que retorna uma instância de [OperationError].
  factory OperationResult.failure(E error) {
    return OperationError<R, E>(error);
  }

  /// Cria um resultado de sucesso com o valor especificado.
  ///
  /// Factory constructor que retorna uma instância de [OperationSuccess].
  factory OperationResult.success(R result) {
    return OperationSuccess<R, E>(result);
  }

  /// Retorna o erro se o resultado for uma falha.
  ///
  /// Lança [StateError] se o resultado for um sucesso.
  /// Use [hasError] para verificar antes de acessar este getter.
  E get asError {
    if (this is OperationError<R, E>) {
      return (this as OperationError<R, E>).error;
    }
    throw StateError('OperationResult is not an error');
  }

  /// Retorna o valor se o resultado for um sucesso.
  ///
  /// Lança [StateError] se o resultado for uma falha.
  /// Use [isSuccessful] para verificar antes de acessar este getter.
  R get asSuccess {
    if (this is OperationSuccess<R, E>) {
      return (this as OperationSuccess<R, E>).result;
    }
    throw StateError('OperationResult is not a success');
  }

  /// Verifica se o resultado representa um erro.
  ///
  /// Retorna `true` se a operação falhou, `false` caso contrário.
  bool get hasError => this is OperationError<R, E>;

  /// Verifica se o resultado representa um sucesso.
  ///
  /// Retorna `true` se a operação foi bem-sucedida, `false` caso contrário.
  bool get isSuccessful => this is OperationSuccess<R, E>;

  /// Executa uma função baseada no tipo de resultado.
  ///
  /// Este método implementa pattern matching, executando [onSuccess]
  /// se o resultado for um sucesso, ou [onFailure] se for um erro.
  ///
  /// Exemplo:
  /// ```dart
  /// resultado.when(
  ///   onSuccess: (valor) => mostrarSucesso(valor),
  ///   onFailure: (erro) => mostrarErro(erro),
  /// );
  /// ```
  void when({
    required void Function(R valor) onSuccess,
    required void Function(E error) onFailure,
  }) {
    if (this is OperationSuccess<R, E>) {
      onSuccess((this as OperationSuccess<R, E>).result);
    } else if (this is OperationError<R, E>) {
      onFailure((this as OperationError<R, E>).error);
    }
  }
}

/// Representa o resultado de uma operação bem-sucedida.
///
/// Contém o valor resultante da execução da operação.
/// Esta classe é uma subclasse de [OperationResult] e indica que
/// a operação foi concluída com sucesso.
///
/// Tipo genérico:
/// - [R]: Tipo do resultado em caso de sucesso
/// - [E]: Tipo do erro em caso de falha
class OperationSuccess<R, E> extends OperationResult<R, E> {
  /// O valor resultante da operação bem-sucedida.
  final R result;

  /// Cria uma instância de sucesso com o resultado especificado.
  OperationSuccess(this.result);
}
