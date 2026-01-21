import 'package:freezed_annotation/freezed_annotation.dart';

/// Representa o resultado de uma operação com falha.
///
/// Contém o erro ocorrido durante a execução da operação.
/// Esta classe é uma subclasse de [ExecutionResult] e indica que
/// a operação não foi concluída com sucesso.
///
/// Tipo genérico:
/// - [R]: Tipo do resultado em caso de sucesso
/// - [E]: Tipo do erro em caso de falha
class ExecutionError<R, E> extends ExecutionResult<R, E> {
  /// O erro que ocorreu durante a operação.
  final E failure;

  /// Cria uma instância de erro com o erro especificado.
  ExecutionError(this.failure);
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
sealed class ExecutionResult<R, E> {
  /// Construtor protegido para uso interno das subclasses.
  @protected
  ExecutionResult();

  /// Cria um resultado de falha com o erro especificado.
  ///
  /// Factory constructor que retorna uma instância de [ExecutionError].
  factory ExecutionResult.error(E error) {
    return ExecutionError<R, E>(error);
  }

  /// Cria um resultado de sucesso com o valor especificado.
  ///
  /// Factory constructor que retorna uma instância de [ExecutionSuccess].
  factory ExecutionResult.success(R result) {
    return ExecutionSuccess<R, E>(result);
  }

  /// Retorna o erro se o resultado for uma falha.
  ///
  /// Lança [StateError] se o resultado for um sucesso.
  /// Use [hasError] para verificar antes de acessar este getter.
  E get asError {
    if (this is ExecutionError<R, E>) {
      return (this as ExecutionError<R, E>).failure;
    }
    throw StateError('OperationResult is not an error');
  }

  /// Retorna o valor se o resultado for um sucesso.
  ///
  /// Lança [StateError] se o resultado for uma falha.
  /// Use [isSuccessful] para verificar antes de acessar este getter.
  R get asSuccess {
    if (this is ExecutionSuccess<R, E>) {
      return (this as ExecutionSuccess<R, E>).result;
    }
    throw StateError('OperationResult is not a success');
  }

  /// Verifica se o resultado representa um erro.
  ///
  /// Retorna `true` se a operação falhou, `false` caso contrário.
  bool get hasError => this is ExecutionError<R, E>;

  /// Verifica se o resultado representa um sucesso.
  ///
  /// Retorna `true` se a operação foi bem-sucedida, `false` caso contrário.
  bool get isSuccessful => this is ExecutionSuccess<R, E>;

  /// Executa uma função baseada no tipo de resultado.
  ///
  /// Este método implementa pattern matching, executando [onSuccess]
  /// se o resultado for um sucesso, ou [onError] se for um erro.
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
    required void Function(E error) onError,
  }) {
    if (this is ExecutionSuccess<R, E>) {
      onSuccess((this as ExecutionSuccess<R, E>).result);
    } else if (this is ExecutionError<R, E>) {
      onError((this as ExecutionError<R, E>).failure);
    }
  }
}

/// Representa o resultado de uma operação bem-sucedida.
///
/// Contém o valor resultante da execução da operação.
/// Esta classe é uma subclasse de [ExecutionResult] e indica que
/// a operação foi concluída com sucesso.
///
/// Tipo genérico:
/// - [R]: Tipo do resultado em caso de sucesso
/// - [E]: Tipo do erro em caso de falha
class ExecutionSuccess<R, E> extends ExecutionResult<R, E> {
  /// O valor resultante da operação bem-sucedida.
  final R result;

  /// Cria uma instância de sucesso com o resultado especificado.
  ExecutionSuccess(this.result);
}
